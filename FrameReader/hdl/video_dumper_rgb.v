`timescale 1ns / 100ps

module axis_save_ppm #(
    parameter integer IMG_WIDTH     = 400, 
    parameter integer IMG_HEIGHT    = 300,
    parameter integer THROTTLE_MODE = 1,
    parameter integer THROTTLE_PROB = 50
   
)(
    input  wire        aclk,
    input  wire        aresetn,
    
    // NOTA: Larghezza aumentata a 24 bit per RGB (8 bit per canale)
    input  wire [23:0] s_axis_tdata, 
    input  wire        s_axis_tvalid,
    input  wire        s_axis_tlast,
    input  wire [3:0]  s_axis_tuser,
    output reg         s_axis_tready
);

    integer file_handle;
    string  current_filename;
    integer frame_cnt = 0;
    bit     file_is_open = 0;
    integer total_pixels_written = 0;
    
    // Numero di pixel totali (NON byte, ma pixel)
    localparam integer EXPECTED_PIXELS = IMG_WIDTH * IMG_HEIGHT;
    
     localparam string  FILENAME_BASE = "video_rgb";

    // --- Flow Control ---
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) s_axis_tready <= 0;
        else begin
            if (THROTTLE_MODE == 0) s_axis_tready <= 1'b1;
            else s_axis_tready <= ($urandom_range(0, 99) < THROTTLE_PROB);
        end
    end

    // --- Logica Scrittura PPM (P6) ---
    wire valid_handshake = s_axis_tvalid && s_axis_tready;
    wire start_of_frame  = valid_handshake && s_axis_tuser[0];

    always @(posedge aclk) begin
        if (aresetn) begin
            
            // 1. Apertura File
            if (start_of_frame) begin
                if (file_is_open) $fclose(file_handle);

                $sformat(current_filename, "%s_%0d.ppm", FILENAME_BASE, frame_cnt);
                file_handle = $fopen(current_filename, "wb");
                
                if (file_handle) begin
                    $display("[PPM] Start RGB Frame %0d -> %s", frame_cnt, current_filename);
                    
                    // HEADER P6: Definisce formato "Binary RGB"
                    // Larghezza, Altezza, MaxVal (255)
                    $fwrite(file_handle, "P6\n%0d %0d\n255\n", IMG_WIDTH, IMG_HEIGHT);
                    
                    file_is_open = 1;
                    total_pixels_written = 0;
                end
            end

            // 2. Scrittura Dati (3 Byte per Pixel)
            if (valid_handshake && file_is_open) begin
                
                // IMPORTANTISSIMO: Ordine dei canali (RGB vs BGR)
                // Il formato PPM si aspetta byte in ordine: Red, Green, Blue.
                // Devi sapere come la tua FPGA impacchetta i 24 bit.
                
                // IPOTESI A: RGB (R=[23:16], G=[15:8], B=[7:0])
                /*
                $fwrite(file_handle, "%c", s_axis_tdata[23:16]); // R
                $fwrite(file_handle, "%c", s_axis_tdata[15:8]);  // G
                $fwrite(file_handle, "%c", s_axis_tdata[7:0]);   // B
                */
                
                // IPOTESI B: Standard AXI Video (Spesso B=[23:16], G=[15:8], R=[7:0] o viceversa)
                // Se i colori in GIMP sono invertiti (es. facce blu), scambia questi indici.
                // Esempio generico (R, G, B):
                $fwrite(file_handle, "%c", s_axis_tdata[7:0]);   // Byte 0 (es. R)
                $fwrite(file_handle, "%c", s_axis_tdata[15:8]);  // Byte 1 (es. G)
                $fwrite(file_handle, "%c", s_axis_tdata[23:16]); // Byte 2 (es. B)
                
                total_pixels_written++;

                // 3. Chiusura al completamento dei pixel
                if (total_pixels_written >= EXPECTED_PIXELS) begin
                    $display("[PPM] Frame RGB %0d completato. File chiuso.", frame_cnt);
                    $fclose(file_handle);
                    file_is_open = 0;
                    frame_cnt++;
                end
            end
        end
    end

    final begin
        if (file_is_open) $fclose(file_handle);
    end

endmodule