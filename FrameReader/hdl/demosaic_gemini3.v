`timescale 1ns / 1ps

module axis_bayer_demosaic_final #(
    parameter integer DATA_WIDTH    = 8,     
    parameter integer MAX_IMG_WIDTH = 2048,
    // 0=RGGB, 1=GRBG, 2=GBRG, 3=BGGR
    parameter [1:0]   BAYER_PATTERN = 2'b11 
)(
    input  wire                   clk,
    input  wire                   resetn,
    input  wire [11:0]            cfg_img_width, 

    // Slave Interface
    input  wire [DATA_WIDTH-1:0]  s_axis_tdata,
    input  wire                   s_axis_tvalid,
    output wire                   s_axis_tready, 
    input  wire                   s_axis_tlast,
    input  wire [3:0]             s_axis_tuser, 

    // Master Interface
    output reg [DATA_WIDTH*3-1:0] m_axis_tdata, 
    output reg                    m_axis_tvalid,
    input  wire                   m_axis_tready,
    output reg                    m_axis_tlast,
    output reg [3:0]              m_axis_tuser
);

    // =========================================================================
    // 1. RAM & SKID BUFFER (Gestione Backpressure)
    // =========================================================================
    localparam ADDR_WIDTH = $clog2(MAX_IMG_WIDTH);
    wire [DATA_WIDTH-1:0] lb0_dout, lb1_dout;
    reg  [ADDR_WIDTH-1:0] col_ptr;
    
    wire pipe_adv = s_axis_tvalid && m_axis_tready;
    assign s_axis_tready = m_axis_tready;

    // Line Buffers
    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram0 (
        .clk(clk), .we(pipe_adv), .wr_addr(col_ptr), .din(s_axis_tdata), .rd_addr(col_ptr), .dout(lb0_dout)
    );
    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram1 (
        .clk(clk), .we(pipe_adv), .wr_addr(col_ptr), .din(lb0_dout),     .rd_addr(col_ptr), .dout(lb1_dout)
    );

    always @(posedge clk or negedge resetn) begin
        if (!resetn) col_ptr <= 0;
        else if (pipe_adv) begin
            if (s_axis_tlast || col_ptr == (cfg_img_width - 1)) col_ptr <= 0;
            else col_ptr <= col_ptr + 1;
        end
    end

    // --- SKID BUFFER ---
    // Salva i dati se m_ready va basso ma c'era una lettura RAM in corso
    reg [DATA_WIDTH-1:0] skid_lb0, skid_lb1, skid_din;
    reg [DATA_WIDTH-1:0] din_d1;
    reg skid_valid, pipe_adv_d1;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            skid_valid <= 0; pipe_adv_d1 <= 0; din_d1 <= 0;
            skid_lb0 <= 0; skid_lb1 <= 0; skid_din <= 0;
        end else begin
            pipe_adv_d1 <= pipe_adv;
            if (pipe_adv) din_d1 <= s_axis_tdata; // Input Delay Match

            if (pipe_adv_d1 && !pipe_adv) begin
                skid_lb0   <= lb0_dout;
                skid_lb1   <= lb1_dout;
                skid_din   <= din_d1;
                skid_valid <= 1'b1;
            end else if (pipe_adv) begin
                skid_valid <= 1'b0;
            end
        end
    end

    wire [DATA_WIDTH-1:0] mux_lb0 = skid_valid ? skid_lb0 : lb0_dout;
    wire [DATA_WIDTH-1:0] mux_lb1 = skid_valid ? skid_lb1 : lb1_dout;
    wire [DATA_WIDTH-1:0] mux_din = skid_valid ? skid_din : din_d1;

    // =========================================================================
    // 2. PIPELINE & PHASE LOGIC
    // =========================================================================
    reg [DATA_WIDTH-1:0] t00, t01, t02; 
    reg [DATA_WIDTH-1:0] t10, t11, t12; 
    reg [DATA_WIDTH-1:0] t20, t21, t22; 
    reg [DATA_WIDTH-1:0] r_calc, g_calc, b_calc;
    
    // Phase Tracking
    reg x_phase_d1, x_phase_t22, x_phase_t21, x_phase_t11;
    reg y_phase;
    
    // Contatori per masking corretto
    reg [11:0] x_pos_track;
    reg [11:0] y_line_cnt; // Conta le prime righe per mascherare l'avvio
    
    wire sof_in = s_axis_tuser[0]; 
    reg [3:0] valid_pipe, last_pipe, user_pipe, mask_pipe; 

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_phase <= 0; x_pos_track <= 0; y_line_cnt <= 0;
            x_phase_d1 <= 0; x_phase_t22<=0; x_phase_t21<=0; x_phase_t11<=0;
            m_axis_tvalid <= 0; m_axis_tlast <= 0; m_axis_tuser <= 0; m_axis_tdata <= 0;
            valid_pipe <= 0; last_pipe <= 0; user_pipe <= 0; mask_pipe <= 0;
            t00<=0; t01<=0; t02<=0; t10<=0; t11<=0; t12<=0; t20<=0; t21<=0; t22<=0;
        end else begin
            if (m_axis_tready) begin
                
                // --- OUTPUT STAGE ---
                // Se mask attiva, output nero (Border Suppression)
                if (mask_pipe[3]) m_axis_tdata <= 0; 
                else m_axis_tdata <= {r_calc, g_calc, b_calc}; 
                
                m_axis_tvalid <= valid_pipe[3];
                m_axis_tlast  <= last_pipe[3];
                m_axis_tuser  <= {3'b000, user_pipe[3]};

                // --- INPUT STAGE ---
                if (s_axis_tvalid) begin
                    // Data Shift
                    t00 <= t01; t01 <= t02;
                    t10 <= t11; t11 <= t12;
                    t20 <= t21; t21 <= t22;
                    t02 <= mux_lb1; t12 <= mux_lb0; t22 <= mux_din; 

                    // Phase Shift
                    x_phase_d1  <= col_ptr[0]; 
                    x_phase_t22 <= x_phase_d1; 
                    x_phase_t21 <= x_phase_t22;
                    x_phase_t11 <= x_phase_t21; 

                    // Control Shift
                    valid_pipe <= {valid_pipe[2:0], 1'b1};
                    last_pipe  <= {last_pipe[2:0], s_axis_tlast};
                    user_pipe  <= {user_pipe[2:0], sof_in};
                    
                    // *** FIX MASKING: Usa un contatore di righe, non la fase ***
                    // Maschera se: Prime 2 righe (y_line_cnt < 2) OR bordi laterali
                    mask_pipe  <= {mask_pipe[2:0], (y_line_cnt < 2) || (x_pos_track < 2 || x_pos_track >= cfg_img_width)};

                    // Update Counters
                    if (s_axis_tlast || x_pos_track == (cfg_img_width - 1)) begin
                        x_pos_track <= 0;
                        if (sof_in) begin
                            y_phase <= 0;
                            y_line_cnt <= 0; // Reset contatore righe
                        end else begin
                            y_phase <= ~y_phase;
                            if (y_line_cnt < 10) y_line_cnt <= y_line_cnt + 1; // Saturate
                        end
                    end else begin
                        x_pos_track <= x_pos_track + 1;
                    end
                end else begin
                    // Bubble Handling
                    valid_pipe <= {valid_pipe[2:0], 1'b0};
                    last_pipe  <= {last_pipe[2:0], 1'b0};
                    user_pipe  <= {user_pipe[2:0], 1'b0};
                    mask_pipe  <= {mask_pipe[2:0], 1'b1};
                end
            end
        end
    end

    // =========================================================================
    // 3. MATH CORE
    // =========================================================================
    // Nota: y_phase traccia la riga di INPUT (t22). 
    // t11 è sulla riga precedente, quindi usiamo ~y_phase.
    wire [1:0] current_phase = { ~y_phase, x_phase_t11 } ^ BAYER_PATTERN;
    reg [DATA_WIDTH+1:0] sum4;
    reg [DATA_WIDTH:0]   sum2;

    always @(*) begin
        case (current_phase) 
            2'b00: begin // Red Center
                r_calc = t11;
                sum4   = t01 + t21 + t10 + t12;
                g_calc = sum4[DATA_WIDTH+1:2]; 
                sum4   = t00 + t02 + t20 + t22;
                b_calc = sum4[DATA_WIDTH+1:2]; 
            end
            2'b01: begin // Green (Red Row)
                sum2   = t10 + t12;
                r_calc = sum2[DATA_WIDTH:1]; 
                g_calc = t11;
                sum2   = t01 + t21;
                b_calc = sum2[DATA_WIDTH:1]; 
            end
            2'b10: begin // Green (Blue Row)
                sum2   = t01 + t21;
                r_calc = sum2[DATA_WIDTH:1]; 
                g_calc = t11;
                sum2   = t10 + t12;
                b_calc = sum2[DATA_WIDTH:1]; 
            end
            2'b11: begin // Blue Center
                sum4   = t00 + t02 + t20 + t22;
                r_calc = sum4[DATA_WIDTH+1:2]; 
                sum4   = t01 + t21 + t10 + t12;
                g_calc = sum4[DATA_WIDTH+1:2]; 
                b_calc = t11;
            end
        endcase
    end

endmodule

// RAM Invariata
module generic_line_buffer #(parameter DATA_WIDTH=8, ADDR_WIDTH=11)(
    input clk, we, input [ADDR_WIDTH-1:0] wr_addr, rd_addr, input [DATA_WIDTH-1:0] din, output reg [DATA_WIDTH-1:0] dout
);
    reg [DATA_WIDTH-1:0] ram [0:(1<<ADDR_WIDTH)-1];
    always @(posedge clk) begin
        if (we) ram[wr_addr] <= din;
        dout <= ram[rd_addr];
    end
endmodule