`timescale 1ns / 1ps

module axi4_mem_model #(
   
    parameter integer AXI_DATA_WIDTH     = 64,          // Larghezza dati (es. 64 bit per DDR)
    parameter integer AXI_ADDR_WIDTH     = 32,          // Larghezza indirizzi
    parameter integer MEM_DEPTH          = 4096         // Numero di parole (words) in memoria
)(
    input  wire                      aclk,
    input  wire                      aresetn,

    // --- AXI4 Write Address Channel ---
    input  wire [AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input  wire [7:0]                s_axi_awlen,
    input  wire [2:0]                s_axi_awsize,
    input  wire [1:0]                s_axi_awburst,
    input  wire                      s_axi_awvalid,
    output reg                       s_axi_awready,

    // --- AXI4 Write Data Channel ---
    input  wire [AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input  wire [AXI_DATA_WIDTH/8-1:0] s_axi_wstrb,
    input  wire                      s_axi_wlast,
    input  wire                      s_axi_wvalid,
    output reg                       s_axi_wready,

    // --- AXI4 Write Response Channel ---
    output reg  [1:0]                s_axi_bresp,
    output reg                       s_axi_bvalid,
    input  wire                      s_axi_bready,

    // --- AXI4 Read Address Channel ---
    input  wire [AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input  wire [7:0]                s_axi_arlen,   // Burst Length: 0=1 beat, 255=256 beats
    input  wire [2:0]                s_axi_arsize,
    input  wire [1:0]                s_axi_arburst,
    input  wire                      s_axi_arvalid,
    output reg                       s_axi_arready,

    // --- AXI4 Read Data Channel ---
    output reg  [AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output reg  [1:0]                s_axi_rresp,
    output reg                       s_axi_rlast,
    output reg                       s_axi_rvalid,
    input  wire                      s_axi_rready
);

    // Calcolo bit per l'offset dei byte (es. 64-bit = 8 byte -> 3 bit offset)
    localparam integer ADDR_LSB = $clog2(AXI_DATA_WIDTH/8);
     localparam string  INIT_FILE          = "image.mem"; // File di inizializzazione

    // Array di Memoria (Ram comportamentale)
    logic [AXI_DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];

    // Caricamento Iniziale
    initial begin
        // Inizializza a 0 per pulizia
        for (int i = 0; i < MEM_DEPTH; i++) mem[i] = 0;

        // Se il file esiste, caricalo
        if (INIT_FILE != "") begin
            $display("[AXI_MEM] Loading memory from %s", INIT_FILE);
            $readmemh(INIT_FILE, mem);
        end
    end

    // -------------------------------------------------------------------------
    // READ CHANNEL LOGIC (Prioritaria per FrameRD)
    // -------------------------------------------------------------------------
    
    // Stati per la macchina a stati di lettura
    typedef enum logic [1:0] {R_IDLE, R_BURST, R_END} r_state_t;
    r_state_t r_state;

    logic [AXI_ADDR_WIDTH-1:0] r_addr_latch;
    logic [7:0]                r_len_cnt;
    logic [7:0]                r_len_latch;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            s_axi_arready <= 0;
            s_axi_rvalid  <= 0;
            s_axi_rlast   <= 0;
            s_axi_rdata   <= 0;
            s_axi_rresp   <= 0;
            r_state       <= R_IDLE;
        end else begin
            case (r_state)
                
                // 1. Aspetta indirizzo valido
                R_IDLE: begin
                    s_axi_rlast  <= 0;
                    if (s_axi_arvalid) begin
                        s_axi_arready <= 1; // Accetta indirizzo
                        r_addr_latch  <= s_axi_araddr;
                        r_len_latch   <= s_axi_arlen;
                        r_len_cnt     <= 0;
                        r_state       <= R_BURST;
                    end else begin
                        s_axi_arready <= 0;
                    end
                end

                // 2. Esegui Burst Read
                R_BURST: begin
                    s_axi_arready <= 0; // Deasserisci ARREADY dopo handshake

                    // Genera RVALID se il master è pronto o se non abbiamo ancora dato dati
                    if (!s_axi_rvalid || s_axi_rready) begin
                        s_axi_rvalid <= 1;
                        
                        // Lettura Memoria: Converti Byte Address in Word Index
                        // Esempio: Indirizzo 0x08 >> 3 = Indice 1
                        s_axi_rdata  <= mem[(r_addr_latch >> ADDR_LSB)]; 
                        s_axi_rresp  <= 2'b00; // OKAY response

                        // Gestione RLAST
                        if (r_len_cnt == r_len_latch) begin
                            s_axi_rlast <= 1;
                            r_state     <= R_END;
                        end else begin
                            s_axi_rlast <= 0;
                            r_len_cnt   <= r_len_cnt + 1;
                            
                            // Incrementa Indirizzo (Supporto solo INCR mode per semplicità)
                            // Aggiunge n Bytes (DATA_WIDTH/8)
                            r_addr_latch <= r_addr_latch + (AXI_DATA_WIDTH/8);
                        end
                    end
                end

                // 3. Concludi Handshake
                R_END: begin
                    if (s_axi_rready) begin
                        s_axi_rvalid <= 0;
                        s_axi_rlast  <= 0;
                        r_state      <= R_IDLE;
                    end
                end
            endcase
        end
    end

    // -------------------------------------------------------------------------
    // WRITE CHANNEL LOGIC (Semplificata)
    // -------------------------------------------------------------------------
    // Implementazione base: scrive sempre all'indirizzo ricevuto. 
    // Nota: Per una simulazione video di sola lettura, questa parte è opzionale
    // ma utile se vuoi testare la scrittura.

    reg [AXI_ADDR_WIDTH-1:0] w_addr_latch;
    reg w_addr_valid;

    // Write Address
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            s_axi_awready <= 0;
            w_addr_valid  <= 0;
        end else begin
            if (!w_addr_valid && s_axi_awvalid) begin
                s_axi_awready <= 1;
                w_addr_latch  <= s_axi_awaddr;
                w_addr_valid  <= 1;
            end else begin
                s_axi_awready <= 0;
            end
            
            // Reset latch on response
            if (s_axi_bvalid && s_axi_bready) w_addr_valid <= 0;
        end
    end

    // Write Data
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            s_axi_wready <= 0;
            s_axi_bvalid <= 0;
            s_axi_bresp  <= 0;
        end else begin
            // Handshake dati
            if (s_axi_wvalid && !s_axi_wready && w_addr_valid) begin
                s_axi_wready <= 1;
                // Scrittura effettiva (ignoriamo strobes per brevità, assumiamo full write)
                mem[(w_addr_latch >> ADDR_LSB)] <= s_axi_wdata;
                
                // Incremento semplice per burst write
                w_addr_latch <= w_addr_latch + (AXI_DATA_WIDTH/8);
            end else begin
                s_axi_wready <= 0;
            end

            // Risposta BVALID
            if (s_axi_wvalid && s_axi_wready && s_axi_wlast) begin
                s_axi_bvalid <= 1;
            end
            
            if (s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 0;
            end
        end
    end

endmodule