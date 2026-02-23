`timescale 1ns / 1ps

module TimingController #(
    parameter pColorWidth         = 8,
    parameter pPPC                = 1,
    parameter pNChannels          = 3
)(
    input  wire                   iPixelClk,
    input  wire                   iVideoClk,
    input  wire                   rst_n,

    // AXI4-Stream Slave Interface (Input to wrapper)
    input  wire [(pPPC)*(pNChannels)*pColorWidth-1:0]   s_axis_tdata,
    input  wire                   						s_axis_tvalid,
    output wire                   						s_axis_tready,
    input  wire                   						s_axis_tlast,
    input  wire 				  						s_axis_tuser,  // Start of frame

    // Video Interface
    output wire [(pPPC)*(pNChannels)*pColorWidth-1:0]  oVideo,
    output wire                   					   oVsync,
    output wire  									   oHSYnc,
    output wire  									   oDV,
    output wire  									   oDdrFrameStart,

    // Spare input signals from Display Controller (in future will be generated internally)
    input  wire                   iHSync,
    input  wire                   iVSync,
	input  wire                   iDataTrigger,
	input  wire                   iVideoActive,
    input  wire                   iEOF
);

    // Native FIFO Write Signals
    wire                  fifo_wr_en;
  //  wire [FIFO_WIDTH-1:0] fifo_din;
    wire                  fifo_full;

    // Native FIFO Read Signals
    wire                  fifo_rd_en;
  //  wire [FIFO_WIDTH-1:0] fifo_dout;
    wire                  fifo_empty;
    wire                  fifo_valid; // Data valid flag (common in standard FIFOs)
	
	
	
	reg 					rPreStart;
	reg 					rStart;
	reg 					rActiveRegVideoClk;
	reg 					rActiveReg1PixClk;
	reg 					rActiveReg2PixClk;
	wire 					wActiveEdgeVideoClk;
	
	
	wire 				  wERROR;
	
	
	assign oVsync = iVSync;
assign oHSYnc = iHSync;
assign oDV    = fifo_valid;

   assign fifo_rd_en    = iDataTrigger & rStart;
   assign s_axis_tready = ~fifo_full;
   assign wERROR        = fifo_empty & fifo_rd_en;
   assign wActiveEdgeVideoClk = iVideoActive &~ rActiveRegVideoClk;
   
   assign oDdrFrameStart = rActiveReg1PixClk &~ rActiveReg2PixClk;
   
    always @(posedge iPixelClk)
    begin : DDRREADStartControl
		if (~rst_n) begin
			rActiveReg1PixClk <=0;
			rActiveReg2PixClk <=0;
		end else begin
			rActiveReg1PixClk <= iVideoActive;
			rActiveReg2PixClk <= rActiveReg1PixClk;
		end
	
	end
   
   
    always @(posedge iVideoClk)
    begin : StartControl
		if (~rst_n) begin
			rPreStart 			<= 0;
			rStart 				<= 0;
			rActiveRegVideoClk  <=0;
		end else begin
			rActiveRegVideoClk <= iVideoActive;
			if (iEOF &~ rPreStart) rPreStart<=1; //Pre-start on end of frame
			if (rPreStart==1 && rStart==0 && wActiveEdgeVideoClk==1) rStart<=1; //start after first EOF and Rising edge of Video Active
		end
	
	end
   
    TCTRL_FIFO iRateSmoother(
    // Inputs
    .DATA		(s_axis_tdata),
    .RCLOCK		(iVideoClk),
    .RE			(fifo_rd_en),
    .RRESET_N	(rst_n),
    .WCLOCK		(iPixelClk),
    .WE			(s_axis_tvalid),
    .WRESET_N	(rst_n),
    // Outputs
    .DVLD		(fifo_valid),
    .EMPTY		(fifo_empty),
    .FULL		(fifo_full),
    .Q          (oVideo)
);
   

endmodule

