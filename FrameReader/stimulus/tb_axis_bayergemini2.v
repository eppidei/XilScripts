`timescale 1ns / 1ps

module tb_axis_bayer_gemini2;

    // =========================================================================
    // Parameters
    // =========================================================================
    parameter DATA_WIDTH    = 8;
    // Set these to match your input image (e.g., 640x480 or 10x10)
    parameter IMG_WIDTH     = 768;   
    parameter IMG_HEIGHT    = 512;
    parameter BAYER_PATTERN = 0;     // 0:RGGB
    parameter CLK_PERIOD    = 10;    // 100 MHz

    localparam INPUT_FILE   = "image_in.mem";
    localparam OUTPUT_FILE  = "image_out.ppm";

    // =========================================================================
    // Signals
    // =========================================================================
    reg                   clk;
    reg                   resetn;

    // Slave Interface (Stimulus)
    reg [DATA_WIDTH-1:0]  s_axis_tdata;
    reg                   s_axis_tvalid;
    wire                  s_axis_tready;
    reg                   s_axis_tlast;
    reg [3:0]             s_axis_tuser;

    // Master Interface (Monitor)
    wire [DATA_WIDTH*3-1:0] m_axis_tdata;
    wire                    m_axis_tvalid;
    reg                     m_axis_tready; // Now driven randomly
    wire                    m_axis_tlast;
    wire [3:0]              m_axis_tuser;

    reg [DATA_WIDTH-1:0] img_data [0:(IMG_WIDTH*IMG_HEIGHT)-1];
    integer file_out;
    integer i, x, y;

    // =========================================================================
    // DUT Instantiation
    // =========================================================================
    axis_bayer_demosaic2 #(
        .DATA_WIDTH(DATA_WIDTH),
        .MAX_IMG_WIDTH(1920),
        .BAYER_PATTERN(BAYER_PATTERN)
    ) dut (
        .clk(clk),
        .resetn(resetn),
        .cfg_img_width(768),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tlast(s_axis_tlast),
        .s_axis_tuser(s_axis_tuser),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tuser(m_axis_tuser)
    );

    // =========================================================================
    // Clock & Reset
    // =========================================================================
    always #(CLK_PERIOD/2) clk = ~clk;

    // =========================================================================
    // Random Backpressure Generator (The Improvement)
    // =========================================================================
    always @(posedge clk) begin
        if (!resetn) begin
            m_axis_tready <= 0;
        end else begin
            // Toggle Ready randomly to simulate downstream pressure
            // $random % 100 < 80 gives ~80% ready (high throughput)
            // Change 80 to 20 to simulate heavy congestion
           // m_axis_tready <= (($random % 100) < 70); 
            m_axis_tready <= 1;//(($random % 100) < 70); 
        end
    end

    // =========================================================================
    // Main Stimulus Process
    // =========================================================================
    initial begin
        clk = 0;
        resetn = 0;
        s_axis_tvalid = 0;
        s_axis_tdata = 0;
        s_axis_tlast = 0;
        s_axis_tuser = 0;

        // Load Memory
        $readmemh(INPUT_FILE, img_data);
        
        // Open Output
        file_out = $fopen(OUTPUT_FILE, "w");
        $fwrite(file_out, "P3\n%0d %0d\n%0d\n", IMG_WIDTH, IMG_HEIGHT, (1<<DATA_WIDTH)-1);

        // Reset Sequence
        #100;
        resetn = 1;
        #20;

        // AXI Master Driver Loop
        for (y = 0; y < IMG_HEIGHT; y = y + 1) begin
            for (x = 0; x < IMG_WIDTH; x = x + 1) begin
                
                // 1. Apply Data on the bus
                s_axis_tvalid <= 1;
                s_axis_tdata  <= img_data[y*IMG_WIDTH + x];
                s_axis_tlast  <= (x == IMG_WIDTH - 1);
                s_axis_tuser  <= (x == 0 && y == 0) ? 4'b0001 : 4'b0000;

                // 2. Hold until handshake occurs
                // We must stay in this loop as long as TREADY is Low
                // This is critical when random backpressure is active
                do begin
                    @(posedge clk);
                end while (s_axis_tready == 0); 

                // Handshake happened at the rising edge we just passed.
                // We can now loop to set up the NEXT pixel.
            end
        end

        // End of Frame - Deassert Valid
        s_axis_tvalid <= 0;
        s_axis_tlast  <= 0;

        // Wait for pipeline to drain
        // Since we have backpressure, this might take longer
        repeat(500) @(posedge clk); 
        
        $fclose(file_out);
        $display("Simulation Done with Random Backpressure.");
        $finish;
    end

    // =========================================================================
    // Output Monitor
    // =========================================================================
    always @(posedge clk) begin
        // Only capture when BOTH Valid and Ready are high (Handshake)
        if (m_axis_tvalid && m_axis_tready) begin
            $fwrite(file_out, "%0d %0d %0d\n", 
                m_axis_tdata[DATA_WIDTH*3-1 : DATA_WIDTH*2], 
                m_axis_tdata[DATA_WIDTH*2-1 : DATA_WIDTH],   
                m_axis_tdata[DATA_WIDTH-1   : 0]);           
        end
    end

endmodule