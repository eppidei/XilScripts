//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Feb 22 15:03:07 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD_TB
module FrameRD_TB(
);

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CLK_GEN_PIXCLK_0_CLK;
wire          DDR_CLK_0_CLK;
wire   [23:0] FrameRD_0_M_AXIS_TDATA;
wire          FrameRD_0_M_AXIS_TLAST;
wire          FrameRD_0_M_AXIS_TREADY;
wire          FrameRD_0_M_AXIS_TVALID;
wire          RDYCTRL_0_oRdy;
wire          RESET_GEN_C0_0_RESET;
wire          VideoClock_CLK;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [7:0]  s_axis_tdata_const_net_0;
wire   [3:0]  s_axis_tuser_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire          FrameRD_0_M_AXIS_TUSER;
wire   [3:0]  FrameRD_0_M_AXIS_TUSER_0;
wire   [0:0]  FrameRD_0_M_AXIS_TUSER_0_0to0;
wire   [3:1]  FrameRD_0_M_AXIS_TUSER_0_3to1;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                  = 1'b0;
assign s_axis_tdata_const_net_0 = 8'h00;
assign s_axis_tuser_const_net_0 = 4'h0;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign FrameRD_0_M_AXIS_TUSER_0 = { FrameRD_0_M_AXIS_TUSER_0_3to1, FrameRD_0_M_AXIS_TUSER_0_0to0 };
assign FrameRD_0_M_AXIS_TUSER_0_0to0 = FrameRD_0_M_AXIS_TUSER;
assign FrameRD_0_M_AXIS_TUSER_0_3to1 = 3'h0;

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------axis_save_ppm
axis_save_ppm #( 
        .IMG_HEIGHT    ( 1080 ),
        .IMG_WIDTH     ( 1920 ),
        .THROTTLE_MODE ( 1 ),
        .THROTTLE_PROB ( 50 ) )
axis_save_ppm_0(
        // Inputs
        .aclk          ( CLK_GEN_PIXCLK_0_CLK ),
        .aresetn       ( RESET_GEN_C0_0_RESET ),
        .s_axis_tdata  ( FrameRD_0_M_AXIS_TDATA ),
        .s_axis_tvalid ( FrameRD_0_M_AXIS_TVALID ),
        .s_axis_tlast  ( FrameRD_0_M_AXIS_TLAST ),
        .s_axis_tuser  ( FrameRD_0_M_AXIS_TUSER_0 ),
        // Outputs
        .s_axis_tready ( FrameRD_0_M_AXIS_TREADY ) 
        );

//--------axis_save_pgm2
axis_save_pgm2 axis_video_to_pgm_0(
        // Inputs
        .aclk          ( GND_net ),
        .aresetn       ( GND_net ),
        .s_axis_tvalid ( GND_net ),
        .s_axis_tlast  ( GND_net ),
        .s_axis_tdata  ( s_axis_tdata_const_net_0 ),
        .s_axis_tuser  ( s_axis_tuser_const_net_0 ),
        // Outputs
        .s_axis_tready (  ) 
        );

//--------CLK_GEN_PIXCLK
CLK_GEN_PIXCLK CLK_GEN_PIXCLK_0(
        // Outputs
        .CLK ( CLK_GEN_PIXCLK_0_CLK ) 
        );

//--------DDR_CLK
DDR_CLK DDR_CLK_0(
        // Outputs
        .CLK ( DDR_CLK_0_CLK ) 
        );

//--------FrameRD
FrameRD FrameRD_0(
        // Inputs
        .rstn_i         ( RESET_GEN_C0_0_RESET ),
        .video_clk      ( VideoClock_CLK ),
        .ddr_clk_i      ( DDR_CLK_0_CLK ),
        .pixel_clk      ( CLK_GEN_PIXCLK_0_CLK ),
        .M_AXIS_iTREADY ( FrameRD_0_M_AXIS_TREADY ),
        // Outputs
        .M_AXIS_oTVALID ( FrameRD_0_M_AXIS_TVALID ),
        .M_AXIS_oTDATA  ( FrameRD_0_M_AXIS_TDATA ),
        .M_AXIS_oTLAST  ( FrameRD_0_M_AXIS_TLAST ),
        .M_AXIS_oTUSER  ( FrameRD_0_M_AXIS_TUSER ) 
        );

//--------RDYCTRL
RDYCTRL RDYCTRL_0(
        // Inputs
        .iCLK  ( CLK_GEN_PIXCLK_0_CLK ),
        .iRSTN ( RESET_GEN_C0_0_RESET ),
        // Outputs
        .oRdy  ( RDYCTRL_0_oRdy ) 
        );

//--------RESET_GEN_C0
RESET_GEN_C0 RESET_GEN_C0_0(
        // Outputs
        .RESET ( RESET_GEN_C0_0_RESET ) 
        );

//--------CLK_GEN_C0
CLK_GEN_C0 VideoClock(
        // Outputs
        .CLK ( VideoClock_CLK ) 
        );


endmodule
