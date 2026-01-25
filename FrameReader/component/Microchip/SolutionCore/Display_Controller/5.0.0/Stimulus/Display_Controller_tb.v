/*-------------------------------------------------------------------------------------------------
 --
 -- File Name         : Display_Controller_tb.v 
 -- Description       : This module generates display controller and sync information for display.
 -- Targeted device   : Microchip FPGAs                    
 -- Author            : India Solutions Team
 --
 -- COPYRIGHT 2022 BY MICROSEMI 
 -- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
 -- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
 -- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
 -- NO BACK-UP OF THE FILE SHOULD BE MADE. 
 -- 
 -------------------------------------------------------------------------------------------------*/
/*=================================================================================================
 -- Display_Controller_tb entity declaration
 --===============================================================================================*/
`timescale 1ns/100ps

module Display_Controller_tb();

   //=================================================================================================
   //-- Parameter declarations
   //--===============================================================================================
   
   //Video format selection
	parameter g_VIDEO_TIMINGS = 0 , // -- 0 -> Predefined timings	
	//-- 1 -> Configurable
	parameter g_VIDEO_RESOLUTION = 4 ; //-- 0 -> 1280x720 
	//-- 1 -> 1920x1080 
	//-- 2 -> 3840x2160 
	//-- 3 -> 640x360
	//-- 4 -> 720x480
	//--- Pixel data Width
	parameter g_PIXELS_DATA_WIDTH = 24; //--   8 -> "  8" Pixel data width 
	//--  16 -> " 16" Pixel data width 
	//--  24 -> " 24" Pixel data width 
	//--  32 -> " 32" Pixel data width 
	//--  40 -> " 40" Pixel data width 
	//--  48 -> " 48" Pixel data width 
	//--  56 -> " 56" Pixel data width 
	//--  64 -> " 64" Pixel data width 
	//--  72 -> " 72" Pixel data width 
	//--  80 -> " 80" Pixel data width 
	//--  88 -> " 88" Pixel data width 
	//--  96 -> " 96" Pixel data width 
	//-- 104 -> "104" Pixel data width 
	//-- 112 -> "112" Pixel data width 
	//-- 120 -> "120" Pixel data width 
	//--- Pixel per clock
	parameter g_PIXELS_PER_CLK = 1 ; //-- 1 -> "1" Pixel per clock 
	//-- 4 -> "4" Pixel per clock 
	
	//--- Pixel per clock
	parameter g_ENABLE_EXT_SYNC = 0 ; //-- 1 -> Enables the EXT_SYNC_SIGNAL 
	//        which needs to connect from the last module just before Display controller flow
	//-- 0 -> Disables the EXT_SYNC_SIGNAL
	
	//--- Selecting AXI4 Lite for IP configuration
	parameter g_STROBE_EN = 0; //-- 0 -> Disable AXI4 Lite Configuration interface
	parameter g_HSYNC_POLARITY = 1; //-- 0 -> Disable AXI4 Lite Configuration interface
	parameter g_VSYNC_POLARITY = 1; //-- 0 -> Disable AXI4 Lite Configuration interface
	parameter g_CONFIGURATION_INTERFACE = 0; //-- 0 -> Disable AXI4 Lite Configuration interface
	//-- 1 -> ENABLE AXI4 Lite Configuration interface
	
	//--- Selecting for Native stream or AXI4 stream  interface
	parameter g_AXI4STREAM_INTERFACE = 0;   //-- 0 -> Native -- 1 -> AXI4 Stream
	//-- 1 -> Display_Controller with AXI	,
	parameter g_VIDEO_DISPLAY_METHOD = 1 ;// 0 -> for Progressive mode
		// 1 -> 4 Interlaced Mode
	
	parameter SYSCLK_PERIOD = 10 ;
	parameter ACLK_PERIOD = 20;
	parameter HRES = 'h280;
	parameter VRES = 'h168;
	parameter H_F_PORCH = 'h58;
	parameter H_B_PORCH = 'h94;
	parameter V_F_PORCH = 'h4;
	parameter V_B_PORCH = 'h24;
	parameter HSYNC_WIDTH = 'h2c;
	parameter VSYNC_WIDTH = 'h5;
   
   
   
   /*
           assign s_h_resolution	= 16'h0140;
           assign s_v_resolution	= 16'h02D0;
           assign s_h_f_porch   	= 16'h001B;
           assign s_h_b_porch      = 16'h0037;
           assign s_v_f_porch      = 16'h0005;
           assign s_v_b_porch      = 16'h0014;
           assign s_h_sync_width   = 16'h000A;
           assign s_v_sync_width   = 16'h0005;
   
   */
   
   
   
   
   
   
   
   /*=================================================================================================
    -- Signal declarations
    --===============================================================================================*/
   wire	     s_h_sync_tb;
   wire	     s_vactive_tb;
   wire	     s_v_sync_tb;
   wire	     s_data_trigger_tb;
   wire	     s_frame_end_tb;
   wire	     s_data_valid_tb;
   wire [15:0] s_h_res_tb;
   wire [15:0] s_v_res_tb;

   reg	       reset_tb;
   reg	       sys_clk_tb;
   reg	       s_ext_sync_signal_tb ;
   reg	       s_start;

   reg	       aclk;
   reg	       arstn;  
   reg [31:0]  awaddr;
   reg	       awvalid;
   reg [2:0]   awprot;
   reg [31:0]  wdata;
   reg	       wvalid;
   reg	       bready;
   reg [31:0]  araddr;
   reg	       arvalid;
   reg [2:0]   arprot;
   reg	       rready;
   wire	       arready;
   wire	       awready;
   wire [1:0]  bresp;
   wire	       bvalid;
   wire [31:0] rdata;
   wire [1:0]  rresp;
   wire	       rvalid;
   wire	       wready;
   
   
   reg 	[15:0]	H_RESOLUTION_I	= 16'd1920 ;
   reg 	[15:0]	V_RESOLUTION_I	= 16'd1080 ;
   reg 	[15:0]	H_F_PORCH_I		= 16'd88 ;
   reg 	[15:0]	H_B_PORCH_I		= 16'd148 ;
   reg 	[15:0]	V_F_PORCH_I		= 16'd4 ;
   reg 	[15:0]	V_F_PORCH_I1	= 16'd3 ;	
   reg 	[15:0]	V_F_PORCH_I2	= 16'd2 ;	
   reg 	[15:0]	V_B_PORCH_I		= 16'd36 ;
   reg 	[15:0]	V_B_PORCH_I1	= 16'd15 ;	
   reg 	[15:0]	V_B_PORCH_I2	= 16'd15 ;	
   reg 	[15:0]	H_SYNC_WIDTH_I	= 16'd44 ;
   reg 	[15:0]	V_SYNC_WIDTH_I	= 16'd5 ;
   reg 	[15:0]	V_SYNC_WIDTH_I1	= 16'd5 ;
   reg 	[15:0]	V_SYNC_WIDTH_I2	= 16'd5 ; 
   /*=================================================================================================
    -- Asynchronous blocks
    --===============================================================================================*/
   initial 

     begin

	reset_tb             = 1'd0;
	sys_clk_tb           = 1'd0;
	s_ext_sync_signal_tb = 1'd0;
	s_start              = 1'd0;
	aclk  = 1'd0;	
	arstn = 1'd0;	
	axi4lite_init;	
     end

   always @(sys_clk_tb)
     #(SYSCLK_PERIOD / 2.0) sys_clk_tb <= !sys_clk_tb;

 always @(aclk)
     #(ACLK_PERIOD / 2.0) aclk <= !aclk;
   
   initial
     begin
	#(SYSCLK_PERIOD * 10 )        reset_tb = 1'b1;
	#(ACLK_PERIOD * 10)	arstn = 1;          	
     end

   always
     begin
	if (s_start == 1'd1) 
	  begin
	     s_ext_sync_signal_tb <= 1'd1;
	     #(1920 * SYSCLK_PERIOD);
	     s_ext_sync_signal_tb <= 1'd0;
	     #(280 * SYSCLK_PERIOD);	   
	  end
	else
	  begin
	     s_ext_sync_signal_tb <= 1'd0;
	     #(66000 * SYSCLK_PERIOD)
	     s_start <= 1'd1;
	  end 	
     end

    top_hdmi_timing_gen 
    #(
        .g_PIXEL_MODE(1)
    )
    INST_top_hdmi_timing_gen
    (
        .SYS_CLK_I(sys_clk_tb),
        .RESETN_I(reset_tb),
        .HSYNC_O(),
        .VSYNC_O(),
        .DV_O()
    ); 
     
   /*=================================================================================================
    -- Component Instantiations
    --===============================================================================================*/ 
   display_controller_top_CNFG_Mod # (
			.g_VIDEO_TIMINGS			(g_VIDEO_TIMINGS	),
			.g_VIDEO_RESOLUTION			(g_VIDEO_RESOLUTION	),
			.g_AXI4STREAM_INTERFACE		(g_AXI4STREAM_INTERFACE	),
			.g_CONFIGURATION_INTERFACE	(g_CONFIGURATION_INTERFACE	),		  			 
			.g_PIXELS_DATA_WIDTH		(g_PIXELS_DATA_WIDTH	),
			.g_ENABLE_EXT_SYNC			(g_ENABLE_EXT_SYNC	),
			.g_HSYNC_POLARITY					(g_HSYNC_POLARITY	),
			.g_VSYNC_POLARITY					(g_VSYNC_POLARITY	),
			.g_STROBE_EN				(g_STROBE_EN	),
			.g_PIXELS_PER_CLK			(g_PIXELS_PER_CLK	),
            .g_VIDEO_DISPLAY_METHOD		(g_VIDEO_DISPLAY_METHOD)	 
			 
			 )  
   display_controller_top_CNFG_Mod   (
			 .AXI4L_CLK_I(aclk),
			 .AXI4L_RESETN_I(arstn),
			 .awvalid(awvalid),
			 .awready(awready),
			 .awaddr(awaddr),
			 .wdata(wdata),
			 .wvalid(wvalid),
			 .wready(wready),
			 .bresp(bresp),
			 .bvalid(bvalid),
			 .bready(bready),
			 .araddr(araddr),
			 .arvalid(arvalid),
			 .arready(arready),
			 .rready(rready),
			 .rdata(rdata),
			 .rresp(rresp),
			 .rvalid(rvalid),            
			 .SYS_CLK_I                           (sys_clk_tb                ), 
			 .RESETN_I                            (reset_tb                  ),
			 .ENABLE_I 	                       (1'd1                      ),			 
			 .EXT_SYNC_SIGNAL_I                   (s_ext_sync_signal_tb      ),
			 .H_RESOLUTION_I						 (H_RESOLUTION_I		),
			 .V_RESOLUTION_I						 (V_RESOLUTION_I		),
			 .H_F_PORCH_I						 (H_F_PORCH_I			),   
			 .H_B_PORCH_I						 (H_B_PORCH_I			),   
			 .V_F_PORCH_I						 (V_F_PORCH_I			),   
			 .V_F_PORCH_I1						 (V_F_PORCH_I1			),   
			 .V_F_PORCH_I2						 (V_F_PORCH_I2			),   
			 .V_B_PORCH_I						 (V_B_PORCH_I			),   
			 .V_B_PORCH_I1						 (V_B_PORCH_I1			),   
			 .V_B_PORCH_I2						 (V_B_PORCH_I2			),   
			 .H_SYNC_WIDTH_I						 (H_SYNC_WIDTH_I		),
			 .V_SYNC_WIDTH_I						 (V_SYNC_WIDTH_I		),
			 .V_SYNC_WIDTH_I1					 (V_SYNC_WIDTH_I1		),
			 .V_SYNC_WIDTH_I2					 (V_SYNC_WIDTH_I2		), 
			 .
			 .TVALID_I	                           (1'd0                      ),	  
			 .TDATA_I	                           (24'd0                     ),	  
			 .DATA_I	                           (24'd0                     ),
			 .H_SYNC_O                            (s_h_sync_tb               ), 
			 .V_SYNC_O                            (s_v_sync_tb               ), 
			 .V_ACTIVE_O	                       (s_vactive_tb              ), 
			 .DATA_TRIGGER_O                      (s_data_trigger_tb         ), 
			 .FRAME_END_O                         (s_frame_end_tb            ), 
			 .DATA_VALID_O                        (s_data_valid_tb           ), 
			 .V_RES_O                             (s_v_res_tb                ), 
			 .H_RES_O                             (s_h_res_tb                ),
			 .TREADY_O	                           (                          ),	  
			 .DATA_O	                           (                          ),	  
			 .TLAST_O	                           (                          ),	  
			 .TVALID_O	                           (                          ),	  
			 .TDATA_O	                           (                          ),	  
			 .TSTRB_O	                           (                          ),	  
			 .TKEEP_O	                           (                          ),	  
			 .TUSER_O	                           (                          )	  
			 );  

   /************************************************************************
    Configuration register write 
    *************************************************************************/ 
   task automatic config_reg_write;
      input [7:0] addr;
      input [31:0] data;
      begin
	 awaddr[31:8] = 0;
	 awaddr[7:0] = addr;	 
	 wdata = data;
	 
	 @(posedge aclk);
	 awvalid = 1;
	 wait(awready);
	 @(posedge aclk);
	 awvalid = 0;
	 @(posedge aclk);    
	 wvalid  = 1;
	 @(posedge aclk);    
	 wvalid = 0;
	 @(posedge aclk);
	 bready = 1;
	 @(posedge aclk);
	 bready = 0;
	 @(posedge aclk);	 
	 
      end
   endtask 



   //////////////////////////////////////////////////////////////////////
   // Enable the IP
   //////////////////////////////////////////////////////////////////////
   task axi4lite_init;      
     begin
	awvalid = 0;
	awaddr = 0;
	wvalid = 0;
	wdata = 0;
	awprot = 0;
	bready = 0;
	araddr = 0;
	arvalid = 0;
	arprot = 0;
	rready = 0;
	
	#(ACLK_PERIOD * 50);
	config_reg_write(8'h04, 32'h0002); //reset the IP
	config_reg_write(8'h08, HRES);
	config_reg_write(8'h0C, VRES);
	config_reg_write(8'h10, H_F_PORCH);
	config_reg_write(8'h14, H_B_PORCH); 	
	config_reg_write(8'h18, V_F_PORCH);
	config_reg_write(8'h1C, V_B_PORCH);
	config_reg_write(8'h20, HSYNC_WIDTH);
	config_reg_write(8'h24, VSYNC_WIDTH);		
	config_reg_write(8'h04, 32'h0001); //enabling the ip
     end
   
   endtask // axi4lite_init

   
endmodule  

