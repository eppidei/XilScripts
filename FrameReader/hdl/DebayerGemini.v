`timescale 1ns / 1ps

module axis_bayer_demosaic #(
    parameter DATA_WIDTH    = 10,
    parameter IMG_WIDTH     = 1920,
    parameter BAYER_PATTERN = 0       // 0:RGGB
)(
    input  wire                   clk,
    input  wire                   resetn,

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
    // 1. Line Buffers
    // =========================================================================
    localparam ADDR_WIDTH = $clog2(IMG_WIDTH);

    wire [DATA_WIDTH-1:0] lb0_dout, lb1_dout;
    reg  [ADDR_WIDTH-1:0] col_ptr;
    
    assign s_axis_tready = m_axis_tready;
    wire pipe_step = s_axis_tvalid && m_axis_tready;

    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram0 (
        .clk(clk), .we(pipe_step), .wr_addr(col_ptr), .din(s_axis_tdata), .rd_addr(col_ptr), .dout(lb0_dout)
    );

    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram1 (
        .clk(clk), .we(pipe_step), .wr_addr(col_ptr), .din(lb0_dout),     .rd_addr(col_ptr), .dout(lb1_dout)
    );

    always @(posedge clk or negedge resetn) begin
        if (!resetn) col_ptr <= 0;
        else if (pipe_step) begin
            if (s_axis_tlast) col_ptr <= 0;
            else col_ptr <= col_ptr + 1;
        end
    end

    // =========================================================================
    // 2. Data Pipeline
    // =========================================================================
    reg [DATA_WIDTH-1:0] t00, t01, t02; 
    reg [DATA_WIDTH-1:0] t10, t11, t12; 
    reg [DATA_WIDTH-1:0] t20, t21, t22; 
    
    reg [DATA_WIDTH-1:0] r_out, g_out, b_out;
    reg [DATA_WIDTH+1:0] sum_cross, sum_x, sum_y;

    wire sof_in = s_axis_tuser[0]; 
    reg [11:0] x_count, y_count;
    reg        odd_pix, odd_line;

    // --- CORREZIONE QUI ---
    // La fase deve riferirsi a t11 (centro), che è in ritardo di 1 riga/pix rispetto all'ingresso.
    wire [1:0] phase = {~odd_line, ~odd_pix}; 

    // =========================================================================
    // 3. Control Pipeline & Logic
    // =========================================================================
    reg [2:0] valid_pipe;
    reg [2:0] last_pipe;
    reg [2:0] user_pipe;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_count <= 0; y_count <= 0;
            odd_pix <= 0; odd_line <= 0;
            m_axis_tvalid <= 0;
            m_axis_tlast  <= 0; m_axis_tuser <= 0; m_axis_tdata <= 0;
            valid_pipe <= 0; last_pipe <= 0; user_pipe <= 0;
        end else begin
            if (m_axis_tready) begin
                // Output Drive
                m_axis_tvalid <= valid_pipe[2];
                m_axis_tlast  <= last_pipe[2];
                m_axis_tuser  <= {3'b000, user_pipe[2]};
                m_axis_tdata  <= {r_out, g_out, b_out}; // Packed RGB
                
                if (s_axis_tvalid) begin
                    // Pipeline Advance
                    valid_pipe <= {valid_pipe[1:0], 1'b1};
                    last_pipe  <= {last_pipe[1:0], s_axis_tlast};
                    user_pipe  <= {user_pipe[1:0], sof_in};

                    // Coordinates
                    if (s_axis_tlast) begin
                        x_count <= 0; odd_pix <= 0;
                        if (sof_in) begin y_count <= 0; odd_line <= 0; end
                        else begin y_count <= y_count + 1; odd_line <= ~odd_line; end
                    end else begin
                        x_count <= x_count + 1; odd_pix <= ~odd_pix;
                    end

                    // Window Shift
                    t00 <= t01; t01 <= t02;
                    t10 <= t11; t11 <= t12;
                    t20 <= t21; t21 <= t22;
                    t02 <= lb1_dout;     
                    t12 <= lb0_dout;     
                    t22 <= s_axis_tdata; 

                    // Interpolation (using Corrected Phase)
                    case (phase) 
                        2'b00: begin // Red Center
                            r_out <= t11;
                            g_out <= (t01 + t21 + t10 + t12) >> 2; 
                            b_out <= (t00 + t02 + t20 + t22) >> 2;
                        end
                        2'b01: begin // Green Center (Red Row)
                            r_out <= (t10 + t12) >> 1; 
                            g_out <= t11;
                            b_out <= (t01 + t21) >> 1; 
                        end
                        2'b10: begin // Green Center (Blue Row)
                            r_out <= (t01 + t21) >> 1; 
                            g_out <= t11;
                            b_out <= (t10 + t12) >> 1; 
                        end
                        2'b11: begin // Blue Center
                            r_out <= (t00 + t02 + t20 + t22) >> 2; 
                            g_out <= (t01 + t21 + t10 + t12) >> 2; 
                            b_out <= t11;
                        end
                    endcase

                end else begin
                    // Bubble Handling
                    valid_pipe <= {valid_pipe[1:0], 1'b0};
                    last_pipe  <= {last_pipe[1:0], 1'b0};
                    user_pipe  <= {user_pipe[1:0], 1'b0};
                end
            end
        end
    end
endmodule

// Generic RAM module remains the same
module generic_line_buffer #(
    parameter DATA_WIDTH = 10,
    parameter ADDR_WIDTH = 11 
)(
    input  wire                  clk,
    input  wire                  we,       
    input  wire [ADDR_WIDTH-1:0] wr_addr,  
    input  wire [DATA_WIDTH-1:0] din,      
    input  wire [ADDR_WIDTH-1:0] rd_addr,  
    output reg  [DATA_WIDTH-1:0] dout      
);
    reg [DATA_WIDTH-1:0] ram [0:(1<<ADDR_WIDTH)-1];
    always @(posedge clk) begin
        if (we) ram[wr_addr] <= din;
        dout <= ram[rd_addr];
    end
endmodule