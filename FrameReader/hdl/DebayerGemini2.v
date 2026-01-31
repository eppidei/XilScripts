`timescale 1ns / 1ps

module axis_bayer_demosaic2 #(
    parameter DATA_WIDTH    = 10,
    parameter MAX_IMG_WIDTH = 2048,   // Dimensione FISICA della RAM (Caso peggiore)
    parameter BAYER_PATTERN = 0       // 0:RGGB
)(
    input  wire                   clk,
    input  wire                   resetn,

    // Runtime Configuration
    input  wire [11:0]            cfg_img_width, // Risoluzione Dinamica (es. 640, 1280, 1920)

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
    // 1. Line Buffers (Allocati su MAX_IMG_WIDTH)
    // =========================================================================
    // Calcoliamo i bit necessari per indirizzare la larghezza MASSIMA
    localparam ADDR_WIDTH = $clog2(MAX_IMG_WIDTH);

    wire [DATA_WIDTH-1:0] lb0_dout, lb1_dout;
    reg  [ADDR_WIDTH-1:0] col_ptr;
    
    assign s_axis_tready = m_axis_tready;
    wire pipe_step = s_axis_tvalid && m_axis_tready;

    // I buffer sono istanziati con la profondità statica massima
    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram0 (
        .clk(clk), .we(pipe_step), .wr_addr(col_ptr), .din(s_axis_tdata), .rd_addr(col_ptr), .dout(lb0_dout)
    );

    generic_line_buffer #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_ram1 (
        .clk(clk), .we(pipe_step), .wr_addr(col_ptr), .din(lb0_dout),     .rd_addr(col_ptr), .dout(lb1_dout)
    );

    // Gestione Puntatore:
    // Si resetta su TLAST (standard AXI) oppure se raggiungiamo la larghezza configurata (sicurezza)
    always @(posedge clk or negedge resetn) begin
        if (!resetn) col_ptr <= 0;
        else if (pipe_step) begin
            if (s_axis_tlast || col_ptr == (cfg_img_width - 1)) 
                col_ptr <= 0;
            else 
                col_ptr <= col_ptr + 1;
        end
    end

    // =========================================================================
    // 2. Data Pipeline
    // =========================================================================
    reg [DATA_WIDTH-1:0] t00, t01, t02; 
    reg [DATA_WIDTH-1:0] t10, t11, t12; 
    reg [DATA_WIDTH-1:0] t20, t21, t22; 
    
    reg [DATA_WIDTH-1:0] r_out, g_out, b_out;
    
    // Coordinate Tracking
    wire sof_in = s_axis_tuser[0]; 
    reg [11:0] x_count, y_count;
    reg        odd_pix, odd_line;
    wire [1:0] phase = {~odd_line, ~odd_pix}; // Fase corretta per t11

    // Pipeline Registers
    reg [2:0] valid_pipe;
    reg [2:0] last_pipe;
    reg [2:0] user_pipe;
    reg [2:0] mask_pipe; // Pipeline per nascondere i bordi

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_count <= 0; y_count <= 0;
            odd_pix <= 0; odd_line <= 0;
            m_axis_tvalid <= 0;
            m_axis_tlast  <= 0; m_axis_tuser <= 0; m_axis_tdata <= 0;
            valid_pipe <= 0; last_pipe <= 0; user_pipe <= 0; mask_pipe <= 0;
            // Reset Window
            t00<=0; t01<=0; t02<=0; t10<=0; t11<=0; t12<=0; t20<=0; t21<=0; t22<=0;
        end else begin
            if (m_axis_tready) begin
                // -------------------------------------------------------------
                // Output Stage
                // -------------------------------------------------------------
                // Se mask_pipe[2] è alto, stiamo processando un bordo (sinistro o destro).
                // Forziamo a nero per evitare di vedere pixel "riciclati" dalla RAM.
                if (mask_pipe[2]) begin
                    m_axis_tdata <= 0; 
                end else begin
                    m_axis_tdata <= {r_out, g_out, b_out};
                end
                
                m_axis_tvalid <= valid_pipe[2];
                m_axis_tlast  <= last_pipe[2];
                m_axis_tuser  <= {3'b000, user_pipe[2]};
                
                // -------------------------------------------------------------
                // Input Processing
                // -------------------------------------------------------------
                if (s_axis_tvalid) begin
                    // Pipeline Advance
                    valid_pipe <= {valid_pipe[1:0], 1'b1};
                    last_pipe  <= {last_pipe[1:0], s_axis_tlast};
                    user_pipe  <= {user_pipe[1:0], sof_in};
                    
                    // --- BORDER MASKING DINAMICO ---
                    // Mascheriamo se:
                    // 1. Siamo all'inizio della riga (x < 2) o immagine (y < 2)
                    // 2. Siamo alla FINE della riga dinamica (x >= cfg_img_width)
                    // Nota: x_count segue l'ingresso. La finestra t11 è in ritardo.
                    // Mascherare la fine evita di interpolare con i dati della riga successiva.
                    mask_pipe  <= {mask_pipe[1:0], (y_count < 2 || x_count < 2 || x_count >= cfg_img_width)};

                    // Aggiornamento Coordinate
                    if (s_axis_tlast || x_count == (cfg_img_width - 1)) begin
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

                    // --- MATH CORE (Con correzioni Overflow e Arrotondamento) ---
                    case (phase) 
                        2'b00: begin // Red Center
                            r_out <= t11;
                            g_out <= ({2'b00, t01} + {2'b00, t21} + {2'b00, t10} + {2'b00, t12} + 2'd2) >> 2; 
                            b_out <= ({2'b00, t00} + {2'b00, t02} + {2'b00, t20} + {2'b00, t22} + 2'd2) >> 2;
                        end
                        2'b01: begin // Green Center (Red Row)
                            r_out <= ({1'b0, t10} + {1'b0, t12} + 1'd1) >> 1; 
                            g_out <= t11;
                            b_out <= ({1'b0, t01} + {1'b0, t21} + 1'd1) >> 1; 
                        end
                        2'b10: begin // Green Center (Blue Row)
                            r_out <= ({1'b0, t01} + {1'b0, t21} + 1'd1) >> 1; 
                            g_out <= t11;
                            b_out <= ({1'b0, t10} + {1'b0, t12} + 1'd1) >> 1; 
                        end
                        2'b11: begin // Blue Center
                            r_out <= ({2'b00, t00} + {2'b00, t02} + {2'b00, t20} + {2'b00, t22} + 2'd2) >> 2; 
                            g_out <= ({2'b00, t01} + {2'b00, t21} + {2'b00, t10} + {2'b00, t12} + 2'd2) >> 2; 
                            b_out <= t11;
                        end
                    endcase

                end else begin
                    // Bubble Handling
                    valid_pipe <= {valid_pipe[1:0], 1'b0};
                    last_pipe  <= {last_pipe[1:0], 1'b0};
                    user_pipe  <= {user_pipe[1:0], 1'b0};
                    mask_pipe  <= {mask_pipe[1:0], 1'b1};
                end
            end
        end
    end

endmodule

// =============================================================================
// Generic RAM (Riutilizzabile e Invariata)
// =============================================================================
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