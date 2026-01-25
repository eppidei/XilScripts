//=================================================================================================
//-- File Name                           : DDR_Read_Native.v

//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2021 BY MICROCHIP
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//=================================================================================================
module DDR_Read_Native #( 
        parameter g_MAX_HORIZ_RESOL	            = 1920,
        parameter g_DDR_AXI_DWIDTH_I        = 128,
       // parameter g_DDR_AXI_DWIDTH_O      = 40,
        parameter g_FRAME_GAP               = 1,
        parameter g_NO_OF_PIXEL_STREAMED    = 1,
        parameter g_PIXEL_WIDTH	            = 8	//at the moment only 8 TODO 10
        )
        (
        // Inputs
        input                               reset_i,
        input                               sys_clk_i,
        input                               ddr_clk_i,
        input [15 :0]                       line_gap_i,
        input [15 : 0]                      horz_resl_i,
        input [15 : 0]                      vert_resl_i,
        input                               sof_i,
        input [7  : 0]                      frame_start_addr_i,
        input [11 : 0]                      h_pan_i,
        input [11 : 0]                      v_pan_i,
      //  input                               read_en_i,
        input                               read_ackn_i,
        input                               read_done_i,
        input                               ddr_data_valid_i,
        input [g_DDR_AXI_DWIDTH_I-1 : 0]    wdata_i,
        input                               wdata_ready_i,
        // Outputs
        output [31 : 0]                     read_start_addr_o,
        output                              read_req_o,
        output [7 : 0]                      burst_size_o,
        output                              data_valid_o,
        output                              TLASTo,
        output [g_NO_OF_PIXEL_STREAMED*g_PIXEL_WIDTH+1 -1 : 0]        data_o //length should match lp_Fifo_Rwidth
        );

        localparam lp_ByteLen      = 8;
        localparam lp_STREAM_WIDTH = g_NO_OF_PIXEL_STREAMED*g_PIXEL_WIDTH;
        localparam lp_HresNextPow2 = $clog2(g_MAX_HORIZ_RESOL);
        localparam lp_HresCeiled_Pow2   = 2**$clog2(g_MAX_HORIZ_RESOL);
     //   localparam lp_HresCeiled_Burstsize   = 2**$clog2(g_MAX_HORIZ_RESOL);
        localparam lp_Fifo_Wwidth  = int'(g_DDR_AXI_DWIDTH_I*(1.0+1.0/(g_NO_OF_PIXEL_STREAMED*g_PIXEL_WIDTH))); //adding SOF, TODO 10 Pixel width case
        localparam lp_Fifo_Rwidth  = 2**$clog2(g_NO_OF_PIXEL_STREAMED*g_PIXEL_WIDTH)+1;
        localparam lp_Fifo_Wdepth  = 2*(lp_HresCeiled_Pow2); // max storage 2 lines
        localparam lp_Fifo_Rdepth  = lp_Fifo_Wwidth/lp_Fifo_Rwidth*lp_Fifo_Wdepth; // TODO CHECK ratio is integer
        
        localparam [15:0] lp_MaxNoBurts       = lp_HresCeiled_Pow2*lp_ByteLen/g_DDR_AXI_DWIDTH_I;//assumption resolution rounded to pow2 contains integer number of ddrwidth
        localparam lp_ByteToDiscard = (lp_HresCeiled_Pow2 - g_MAX_HORIZ_RESOL);
        
   
        
//localparam   g_VIDEO_FIFO_DEPTH      = 2*((g_MAX_HORIZ_RESOL*g_DATA_WIDTH)/g_DDR_AXI_DWIDTH_I);
//localparam   g_FIFO_AWIDTH           = $clog2(g_VIDEO_FIFO_DEPTH);
//localparam   g_DATA_WIDTH            = (g_DDR_AXI_DWIDTH_O * g_NO_OF_PIXEL);

//=================================================================================================
// Signal declarations
//=================================================================================================
//wire [lp_STREAM_WIDTH-1 : 0]           data_o_net_0               ;
//wire                                data_valid_o_net_0         ;
wire [7 : 0]                        brust_hcount_o_net_0       ;
//wire [15 : 0]                       beats_to_read_o_net_0      ;
//wire                                data_unpacker_0_fifo_read_o;
wire                                read_req_o_net_0           ;
wire [31 : 0]                       read_start_addr_o_net_0    ;
//wire [g_DDR_AXI_DWIDTH_I-1 : 0]     video_fifo_0_rdata_o_1     ;
//wire                                video_fifo_0_rdata_rdy_o   ;
 
wire                                AND2_0_Y                   ;

wire [$clog2(lp_Fifo_Wdepth) : 0] wWFifoCnt;
wire [$clog2(lp_Fifo_Rdepth) : 0] wRFifoCnt;
wire                                wFifoWen;
wire                                wFifoRen;
wire                                wFifoDataValid;
wire                                wDataValid;
wire                                wFifoFull;
wire                                wFifoEmpty;
wire                                wFifoAlmostEmpty;
wire                                wFifoWArstn;
wire                                wFifoRArstn;
wire   [lp_Fifo_Rwidth-1:0]         wFifoDataOutput;
reg                                 rWAlmostEmpty;
reg  [$clog2(lp_Fifo_Rdepth)-1 : 0] rStreamCnt;
wire [lp_Fifo_Wwidth-1:0] wddr_data_int;// TO DO PARAMETRIZE (g_DDR_AXI_DWIDTH_I/STREAMWIDTH 8)
reg                                 rTLASTo;
wire [15:0]                         wNumBursts ;
 
//=================================================================================================
// Top level output port assignments
//=================================================================================================
 assign read_start_addr_o       = read_start_addr_o_net_0;
 assign read_req_o              = read_req_o_net_0;
 //TODO add calculation instead of table for more flexible block
 assign wNumBursts              = (g_DDR_AXI_DWIDTH_I==64 && horz_resl_i==1920) ? 240 :
                                  (g_DDR_AXI_DWIDTH_I==128 && horz_resl_i==1920) ? 120 :
                                  lp_MaxNoBurts;
 assign burst_size_o            = brust_hcount_o_net_0[7:0];    
 //assign data_valid_o            = data_valid_o_net_0;
 //assign data_o                  = data_o_net_0;
 
//=================================================================================================
// Asynchronous assignments
//=================================================================================================
 //assign AND2_0_Y                = reset_i &(!frame_end_i);
 
//=================================================================================================
// Component instances
//=================================================================================================
 
//-------------------------------------------------------    
// DDR_read_controller_0
//-------------------------------------------------------

DDR_read_controller#(
       // .g_MAX_HORIZ_RESOL          (g_MAX_HORIZ_RESOL),
        .g_DDR_AXI_DWIDTH_I        (g_DDR_AXI_DWIDTH_I),
        .g_PIXEL_WIDTH             (g_PIXEL_WIDTH),
        .g_FRAME_GAP        (g_FRAME_GAP)
        )
    DDR_read_controller_0( 
        // Inputs
        .reset_i             ( reset_i              ),
        .sys_clk_i           ( ddr_clk_i            ),
        .c_LINE_GAP          ( line_gap_i           ),
        .burst_len_i         ( wNumBursts),
        .vert_res_i         ( vert_resl_i),
        .ddr_data_i          (wdata_i),
        .ddr_data_valid_i          (ddr_data_valid_i),
       // .read_en_i           ( read_en_i            ),
        .prefetch_line_i     (  rWAlmostEmpty           ),
        .read_ackn_i         ( read_ackn_i          ),
        .read_done_i         ( read_done_i          ),
        .sof_i                  ( sof_i          ),
        .frame_start_addr_i  ( frame_start_addr_i   ),
        .h_pan_i             ( h_pan_i              ),
        .v_pan_i             ( v_pan_i              ),
        // Outputs
        .ddr_data_o           (wddr_data_int),
        .read_req_o          ( read_req_o_net_0     ),
        .read_start_addr_o   ( read_start_addr_o_net_0),
        .burst_hcount_o      ( brust_hcount_o_net_0 )
        );        
        

   
assign wFifoWen         =   ddr_data_valid_i; 
assign wFifoRen         =   wdata_ready_i &~ wFifoEmpty; 
assign wFifoDataValid   =   wDataValid ;
assign data_valid_o     =   (rStreamCnt>=0 && rStreamCnt<horz_resl_i) ? wFifoDataValid : 0; // we discard some dummy pixels (e.g. 1920 to 2048)
assign data_o           =   wFifoDataOutput;
assign wFifoWArstn      =   reset_i;
assign wFifoRArstn      =   reset_i;

always@(posedge ddr_clk_i)
begin : AlmostEmptyResync
 rWAlmostEmpty <= wFifoAlmostEmpty;
end 


assign TLASTo = rTLASTo;

always@(posedge sys_clk_i)
begin : StreamCounter
    if (!wFifoRArstn) begin
        rStreamCnt <= 0;
        rTLASTo <= 0;
    end
    else begin
        if (wFifoDataValid) begin
        rStreamCnt <= rStreamCnt+1;
        rTLASTo <= 0;
            if (rStreamCnt==lp_HresCeiled_Pow2-1) rStreamCnt <= 0;
            else if (rStreamCnt==horz_resl_i-2) rTLASTo <= 1;
        end
    end
end 
   
DDR_READ_ASYMM_FIFO_DDR_READ_ASYMM_FIFO_0_COREFIFO #( 
        .AE_STATIC_EN ( 1 ),
        .AEVAL        ( g_MAX_HORIZ_RESOL ),
        .AF_STATIC_EN ( 0 ),
        .AFVAL        ( 1020 ),
        .CTRL_TYPE    ( 2 ),
        .DIE_SIZE     ( 5 ),
        .ECC          ( 0 ),
        .ESTOP        ( 1 ),
        .FAMILY       ( 26 ),
        .FSTOP        ( 1 ),
        .FWFT         ( 0 ),
        .NUM_STAGES   ( 2 ),
        .OVERFLOW_EN  ( 0 ),
        .PIPE         ( 1 ),
        .PREFETCH     ( 0 ),
        .RAM_OPT      ( 0 ),
        .RDCNT_EN     ( 1 ),
        .RDEPTH       ( lp_Fifo_Rdepth ),
        .RE_POLARITY  ( 0 ),
        .READ_DVALID  ( 1 ),
        .RWIDTH       ( lp_Fifo_Rwidth ),
        .SYNC         ( 0 ),
        .SYNC_RESET   ( 0 ),
        .UNDERFLOW_EN ( 0 ),
        .WDEPTH       ( lp_Fifo_Wdepth ),
        .WE_POLARITY  ( 0 ),
        .WRCNT_EN     ( 1 ),
        .WRITE_ACK    ( 0 ),
        .WWIDTH       ( lp_Fifo_Wwidth ) )
DDR_READ_ASYMM_FIFO_0(
        // Inputs
        .CLK        ( 1'b0 ), // tied to 1'b0 from definition
        .WCLOCK     ( ddr_clk_i ),
        .RCLOCK     ( sys_clk_i ),
        .RESET_N    ( 1'b0 ), // tied to 1'b0 from definition
        .WRESET_N   ( wFifoWArstn ),
        .RRESET_N   ( wFifoRArstn ),
        .DATA       ( wddr_data_int ),
        .WE         ( wFifoWen ),
        .RE         ( wFifoRen ),
        .MEMRD      ( {lp_Fifo_Rwidth{1'b0}} ), // tied to 8'h00 from definition
        // Outputs
        .Q          ( wFifoDataOutput ),
        .FULL       ( wFifoFull ),
        .EMPTY      ( wFifoEmpty ),
        .AFULL      (  ),
        .AEMPTY     ( wFifoAlmostEmpty ),
        .OVERFLOW   (  ),
        .UNDERFLOW  (  ),
        .WACK       (  ),
        .DVLD       ( wDataValid ),
        .WRCNT      ( wWFifoCnt ),
        .RDCNT      ( wRFifoCnt ),
        .MEMWE      (  ),
        .MEMRE      (  ),
        .MEMWADDR   (  ),
        .MEMRADDR   (  ),
        .MEMWD      (  ),
        .SB_CORRECT (  ),
        .DB_DETECT  (  ) 
        );
   
//-------------------------------------------------------   
//synchronizer_circuit_ddr_read
//-------------------------------------------------------
/*
 synchronizer_circuit_ddr_read
  synchronizer_circuit_ddr_read_0(
	// inputs 
	.rstn_i			(reset_i							), 
	.sys_clk		(sys_clk_i							),
	.data_in		(AND2_0_Y							),
	// output
	.sync_out		(sync_out1							)
	);

//-------------------------------------------------------   
//synchronizer_circuit_ddr_read
//-------------------------------------------------------

 synchronizer_circuit_ddr_read
  synchronizer_circuit_ddr_read_1(
	// inputs 
	.rstn_i			(reset_i							), 
	.sys_clk		(ddr_clk_i						),
	.data_in		(AND2_0_Y							),
	// output
	.sync_out		(sync_out2							)
	);
 */     		
endmodule

