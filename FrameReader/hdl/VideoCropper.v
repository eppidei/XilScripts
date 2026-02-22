module VideoCropper #(
    parameter pColorWidth   = 8,
    parameter pPPC          = 1,
    parameter pNChannels    = 3,
    parameter pMaxHRes      = 1920,
    parameter pMaxVRes      = 1080
)
(
    // Globals
    input                                       iPixClk,
    input                                       iPixRstn,

    // Cropping Coordinates (Inputs)
    input       [$clog2(pMaxHRes)-1:0]          iX1a, // Start X
    input       [$clog2(pMaxVRes)-1:0]          iY1a, // Start Y
    input       [$clog2(pMaxHRes)-1:0]          iX1b, // End X
    input       [$clog2(pMaxVRes)-1:0]          iY1b, // End Y

    // Video Interface Input
    input       [(pPPC)*(pNChannels)*pColorWidth-1:0] iTDATA,
    input                                       iTVALID,
    input                                       iTLAST,
    input                                iTUSER, // iTUSER[0] = SOF
    output                                      oTREADY,

    // Video Interface Output
    output      [(pPPC)*(pNChannels)*pColorWidth-1:0] oTDATA,
    output                                      oTVALID,
    output                                      oTLAST,
    output                              oTUSER,
    input                                       iTREADY
);

   // localparam lpSOF_bit = 0;

    // Internal Registers for Counters and Latching
    reg     [$clog2(pMaxHRes)-1:0]  rHCOUNT0;
    reg     [$clog2(pMaxVRes)-1:0]  rVCOUNT0;
    
    // Registers to latch inputs (Shadow Registers)
    reg     [$clog2(pMaxHRes)-1:0]  rX1a;
    reg     [$clog2(pMaxVRes)-1:0]  rY1a;
    reg     [$clog2(pMaxHRes)-1:0]  rX1b;
    reg     [$clog2(pMaxVRes)-1:0]  rY1b;

    wire                            wSOF;

    // Detect Start Of Frame based on User bit and Valid
    assign wSOF = iTVALID & iTUSER;

    // Latch Input Params Logic
    // Updates cropping window only at the start of a frame to avoid tearing
    always @(posedge iPixClk)
    begin : LatchInputParams
        if (!iPixRstn) begin
            // Default values to avoid corner case of cropping 1 pixel
            rX1a <= 1;
            rY1a <= 1;
            rX1b <= 1;
            rY1b <= 1;
        end else begin
            if (wSOF) begin // VERIFY CORNER CASE 1 row and first col even though rare
                rX1a <= iX1a;
                rY1a <= iY1a;
                rX1b <= iX1b;
                rY1b <= iY1b;
            end
        end
    end

    // Resolution Counter
    // Tracks current pixel position in the incoming stream
    always @(posedge iPixClk)
    begin : ResolutionCounter
        if (!iPixRstn) begin
            rHCOUNT0 <= 0;
            rVCOUNT0 <= 0;
        end else begin
            if (iTVALID & iTREADY) begin
                rHCOUNT0 <= rHCOUNT0 + 1;
                
                // Reset on Start Of Frame
                if (iTUSER) begin
                    rHCOUNT0 <= 1; // Assuming 1-based or next pixel logic from image trace
                    rVCOUNT0 <= 0;
                end 
                // Line End Handling
                else if (iTLAST) begin
                    rHCOUNT0 <= 0;
                    rVCOUNT0 <= rVCOUNT0 + 1;
                end
            end
        end
    end

    // Output Assignments
    
    // Pass-through Ready signal (Backpressure)
    assign oTREADY      = iTREADY;
    
    // Data is passed through, validity is gated by crop window
    assign oTDATA       = iTDATA;
    
    // VALID is high only if we are inside the crop rectangle AND input is valid
    assign oTVALID      = (rHCOUNT0 >= rX1a && rHCOUNT0 <= rX1b && rVCOUNT0 >= rY1a && rVCOUNT0 <= rY1b) ? iTVALID : 0;
    
    // Generate new TLAST at the right edge of the crop window
    assign oTLAST       = (rHCOUNT0 == rX1b) ? 1'b1 : 0;
    
    // Generate new SOF (TUSER[0]) at the top-left corner of the crop window
    assign oTUSER    = (rHCOUNT0 == rX1a && rVCOUNT0 == rY1a) ? 1'b1 : 0;


endmodule