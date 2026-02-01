// ============================================================
// Dual-port RAM
// ============================================================
module dp_ram #(
    parameter DATA_WIDTH = 10,
    parameter ADDR_WIDTH = 11
)(
    input  wire                     clk,
    input  wire                     we_a,
    input  wire [ADDR_WIDTH-1:0]    addr_a,
    input  wire [DATA_WIDTH-1:0]    din_a,
    input  wire [ADDR_WIDTH-1:0]    addr_b,
    output reg  [DATA_WIDTH-1:0]    dout_b
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always @(posedge clk) begin
        if (we_a)
            mem[addr_a] <= din_a;
        dout_b <= mem[addr_b];
    end

endmodule

// ============================================================
// Line buffer (1 line delay using dp_ram)
// ============================================================
module line_buffer #(
    parameter DATA_WIDTH = 10,
    parameter IMG_WIDTH  = 1920,
    parameter ADDR_WIDTH = $clog2(IMG_WIDTH)
)(
    input  wire                     clk,
    input  wire                     rst,

    input  wire                     we,
    input  wire [DATA_WIDTH-1:0]    pixel_in,
    input  wire [ADDR_WIDTH-1:0]    x_write,

    input  wire [ADDR_WIDTH-1:0]    x_read,
    output wire [DATA_WIDTH-1:0]    pixel_out
);

    dp_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) ram_inst (
        .clk    (clk),
        .we_a   (we),
        .addr_a (x_write),
        .din_a  (pixel_in),
        .addr_b (x_read),
        .dout_b (pixel_out)
    );

endmodule

// ============================================================
// Bayer demosaic AXIS (bilinear, SOF in/out, 4-bit tuser)
// ============================================================
module bayer_demosaic_axis #(
    parameter DATA_WIDTH   = 10,
    parameter IMG_WIDTH    = 1920,
    parameter IMG_HEIGHT   = 1080,
    parameter ADDR_WIDTH   = $clog2(IMG_WIDTH),

    // --------------------------------------------------------
    // 0 = RGGB
    // 1 = BGGR
    // 2 = GBRG
    // 3 = GRBG
    // --------------------------------------------------------
    parameter BAYER_FORMAT = 0
)(
    input  wire                     aclk,
    input  wire                     aresetn,

    // AXIS input (Bayer)
    input  wire [DATA_WIDTH-1:0]    s_axis_tdata,
    input  wire                     s_axis_tvalid,
    output wire                     s_axis_tready,
    input  wire                     s_axis_tlast,
    input  wire [3:0]               s_axis_tuser,   // SOF = bit0

    // AXIS output (RGB)
    output reg  [3*DATA_WIDTH-1:0]  m_axis_tdata,
    output reg                      m_axis_tvalid,
    input  wire                     m_axis_tready,
    output reg                      m_axis_tlast,
    output reg  [3:0]               m_axis_tuser
);

    assign s_axis_tready = m_axis_tready;

    // ------------------------------------------------------------
    // X/Y counters
    // ------------------------------------------------------------
    reg [ADDR_WIDTH-1:0] x_cnt;
    reg [$clog2(IMG_HEIGHT+1)-1:0] y_cnt;

    always @(posedge aclk) begin
        if (!aresetn) begin
            x_cnt <= 0;
            y_cnt <= 0;
        end else if (s_axis_tvalid && s_axis_tready) begin
            if (s_axis_tlast) begin
                x_cnt <= 0;
                if (y_cnt == IMG_HEIGHT-1)
                    y_cnt <= 0;
                else
                    y_cnt <= y_cnt + 1;
            end else begin
                x_cnt <= x_cnt + 1;
            end
        end
    end

    // ------------------------------------------------------------
    // Ping-pong line buffers
    // ------------------------------------------------------------
    reg use_buf0_as_prev;
    reg we_line0, we_line1;

    wire [DATA_WIDTH-1:0] line0_out_raw, line1_out_raw;
    wire [DATA_WIDTH-1:0] prev_line_pix, curr_line_pix;

    line_buffer #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH)
    ) linebuf0 (
        .clk      (aclk),
        .rst      (~aresetn),
        .we       (we_line0),
        .pixel_in (s_axis_tdata),
        .x_write  (x_cnt),
        .x_read   (x_cnt),
        .pixel_out(line0_out_raw)
    );

    line_buffer #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH)
    ) linebuf1 (
        .clk      (aclk),
        .rst      (~aresetn),
        .we       (we_line1),
        .pixel_in (s_axis_tdata),
        .x_write  (x_cnt),
        .x_read   (x_cnt),
        .pixel_out(line1_out_raw)
    );

    assign prev_line_pix = use_buf0_as_prev ? line0_out_raw : line1_out_raw;
    assign curr_line_pix = use_buf0_as_prev ? line1_out_raw : line0_out_raw;

    always @(posedge aclk) begin
        if (!aresetn) begin
            use_buf0_as_prev <= 1'b0;
            we_line0 <= 1'b0;
            we_line1 <= 1'b0;
        end else begin
            we_line0 <= 1'b0;
            we_line1 <= 1'b0;

            if (s_axis_tvalid && s_axis_tready) begin
                if (use_buf0_as_prev)
                    we_line1 <= 1'b1;
                else
                    we_line0 <= 1'b1;
            end

            if (s_axis_tvalid && s_axis_tready && s_axis_tlast)
                use_buf0_as_prev <= ~use_buf0_as_prev;
        end
    end

    // ------------------------------------------------------------
    // 3×3 neighborhood
    // ------------------------------------------------------------
    reg [DATA_WIDTH-1:0] c_center, c_left, c_right;
    reg [DATA_WIDTH-1:0] p_center, p_left, p_right;
    reg [DATA_WIDTH-1:0] n_center, n_left, n_right;

    reg in_valid_d;
    reg in_last_d;
    reg [ADDR_WIDTH-1:0] x_cnt_d;
    reg [$clog2(IMG_HEIGHT+1)-1:0] y_cnt_d;
    reg s_axis_tuser_d;

    always @(posedge aclk) begin
        if (!aresetn) begin
            c_center <= 0; c_left <= 0; c_right <= 0;
            p_center <= 0; p_left <= 0; p_right <= 0;
            n_center <= 0; n_left <= 0; n_right <= 0;
            in_valid_d <= 0;
            in_last_d  <= 0;
            x_cnt_d    <= 0;
            y_cnt_d    <= 0;
            s_axis_tuser_d <= 0;
        end else begin
            in_valid_d <= s_axis_tvalid && s_axis_tready;
            in_last_d  <= s_axis_tlast  && s_axis_tvalid && s_axis_tready;
            x_cnt_d    <= x_cnt;
            y_cnt_d    <= y_cnt;

            if (s_axis_tvalid && s_axis_tready)
                s_axis_tuser_d <= s_axis_tuser[0];

            if (s_axis_tvalid && s_axis_tready) begin
                c_left   <= c_center;
                c_center <= curr_line_pix;
                c_right  <= s_axis_tdata;

                p_left   <= p_center;
                p_center <= prev_line_pix;
                p_right  <= prev_line_pix;

                n_left   <= n_center;
                n_center <= s_axis_tdata;
                n_right  <= s_axis_tdata;
            end
        end
    end

    // ------------------------------------------------------------
    // Parametric Bayer pattern decode
    // ------------------------------------------------------------
    wire is_y_even = ~y_cnt_d[0];
    wire is_x_even = ~x_cnt_d[0];

    reg is_R, is_G_Rrow, is_G_Brow, is_B;

    always @(*) begin
        is_R      = 0;
        is_G_Rrow = 0;
        is_G_Brow = 0;
        is_B      = 0;

        case (BAYER_FORMAT)
            0: begin // RGGB
                is_R      =  is_y_even &&  is_x_even;
                is_G_Rrow =  is_y_even && ~is_x_even;
                is_G_Brow = ~is_y_even &&  is_x_even;
                is_B      = ~is_y_even && ~is_x_even;
            end
            1: begin // BGGR
                is_B      =  is_y_even &&  is_x_even;
                is_G_Brow =  is_y_even && ~is_x_even;
                is_G_Rrow = ~is_y_even &&  is_x_even;
                is_R      = ~is_y_even && ~is_x_even;
            end
            2: begin // GBRG
                is_G_Rrow =  is_y_even &&  is_x_even;
                is_B      =  is_y_even && ~is_x_even;
                is_R      = ~is_y_even &&  is_x_even;
                is_G_Brow = ~is_y_even && ~is_x_even;
            end
            3: begin // GRBG
                is_G_Rrow =  is_y_even &&  is_x_even;
                is_R      =  is_y_even && ~is_x_even;
                is_B      = ~is_y_even &&  is_x_even;
                is_G_Brow = ~is_y_even && ~is_x_even;
            end
        endcase
    end

    // ------------------------------------------------------------
    // Bilinear demosaic
    // ------------------------------------------------------------
    reg [DATA_WIDTH-1:0] R, G, B;

    always @(*) begin
        R = 0; G = 0; B = 0;

        if (is_R) begin
            R = c_center;
            G = (c_left + c_right + p_center + n_center) >> 2;
            B = (p_left + p_right + n_left + n_right) >> 2;
        end else if (is_B) begin
            B = c_center;
            G = (c_left + c_right + p_center + n_center) >> 2;
            R = (p_left + p_right + n_left + n_right) >> 2;
        end else if (is_G_Rrow) begin
            G = c_center;
            R = (c_left + c_right) >> 1;
            B = (p_center + n_center) >> 1;
        end else if (is_G_Brow) begin
            G = c_center;
            R = (p_center + n_center) >> 1;
            B = (c_left + c_right) >> 1;
        end
    end

    // ------------------------------------------------------------
    // SOF generation
    // ------------------------------------------------------------
    wire sof_now = s_axis_tuser_d && in_valid_d;

    // ------------------------------------------------------------
    // AXIS output register
    // ------------------------------------------------------------
    always @(posedge aclk) begin
        if (!aresetn) begin
            m_axis_tdata  <= 0;
            m_axis_tvalid <= 0;
            m_axis_tlast  <= 0;
            m_axis_tuser  <= 4'b0000;
        end else begin
            if (in_valid_d) begin
                m_axis_tdata  <= {R, G, B};
                m_axis_tvalid <= 1'b1;
                m_axis_tlast  <= in_last_d;
                m_axis_tuser  <= {3'b000, sof_now};
            end else if (m_axis_tvalid && !m_axis_tready) begin
                m_axis_tvalid <= m_axis_tvalid;
                m_axis_tlast  <= m_axis_tlast;
                m_axis_tuser  <= m_axis_tuser;
            end else begin
                m_axis_tvalid <= 1'b0;
                m_axis_tlast  <= 1'b0;
                m_axis_tuser  <= 4'b0000;
            end
        end
    end

endmodule
