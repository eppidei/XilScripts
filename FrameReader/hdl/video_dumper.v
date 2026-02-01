`timescale 1ns / 100ps

module axis_save_pgm2 #(
    parameter integer IMG_WIDTH     = 400, 
    parameter integer IMG_HEIGHT    = 300,
    parameter integer THROTTLE_MODE = 1,
    parameter integer THROTTLE_PROB = 50
   
)(
    input  wire       aclk,
    input  wire       aresetn,
    
    input  wire [7:0] s_axis_tdata,
    input  wire       s_axis_tvalid,
    input  wire       s_axis_tlast,
    input  wire [3:0] s_axis_tuser,
    output reg        s_axis_tready
);

    integer file_handle;
    string  current_filename;
    integer frame_cnt = 0;
    bit     file_is_open = 0;
    integer total_pixels_written = 0;
    
    // Calcolo dimensione totale attesa
    localparam integer EXPECTED_SIZE = IMG_WIDTH * IMG_HEIGHT;
     localparam string  FILENAME_BASE = "video_out";

    // --- Flow Control ---
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) s_axis_tready <= 0;
        else begin
            if (THROTTLE_MODE == 0) s_axis_tready <= 1'b1;
            else s_axis_tready <= ($urandom_range(0, 99) < THROTTLE_PROB);
        end
    end

    // --- Logica Scrittura ---
    wire valid_handshake = s_axis_tvalid && s_axis_tready;
    wire start_of_frame  = valid_handshake && s_axis_tuser[0];

    always @(posedge aclk) begin
        if (aresetn) begin
            
            // 1. Apertura File (Start of Frame)
            if (start_of_frame) begin
                // Se per caso era rimasto aperto (glitch), chiudilo
                if (file_is_open) $fclose(file_handle);

                $sformat(current_filename, "%s_%0d.pgm", FILENAME_BASE, frame_cnt);
                file_handle = $fopen(current_filename, "wb");
                
                if (file_handle) begin
                    $display("[PGM] Start Frame %0d -> %s", frame_cnt, current_filename);
                    // Header P5
                    $fwrite(file_handle, "P5\n%0d %0d\n255\n", IMG_WIDTH, IMG_HEIGHT);
                    file_is_open = 1;
                    total_pixels_written = 0; // Reset contatore
                end
            end

            // 2. Scrittura Dati
            if (valid_handshake && file_is_open) begin
                $fwrite(file_handle, "%c", s_axis_tdata);
                total_pixels_written++;

                // 3. Chiusura Immediata al raggiungimento della dimensione target
                if (total_pixels_written >= EXPECTED_SIZE) begin
                    $display("[PGM] Frame %0d completato (%0d pixels). File chiuso.", frame_cnt, total_pixels_written);
                    $fclose(file_handle);
                    file_is_open = 0;
                    frame_cnt++; // Prepara indice per prossimo frame
                end
            end
        end
    end

    // Safety: chiusura forzata a fine sim se ancora aperto
    final begin
        if (file_is_open) begin 
            $display("[PGM] Warning: Sim terminata con file aperto (incompleto: %0d/%0d)", total_pixels_written, EXPECTED_SIZE);
            $fclose(file_handle);
        end
    end

endmodule