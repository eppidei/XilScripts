//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Feb  1 22:46:44 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD_TB
module FrameRD_TB(
);

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          axis_save_ppm_0_s_axis_tready;
wire          CLK_GEN_PIXCLK_0_CLK;
wire          DDR_CLK_0_CLK;
wire   [23:0] FrameRD_0_M_AXIS_0_m_axis_tdata;
wire          FrameRD_0_M_AXIS_0_m_axis_tlast;
wire   [3:0]  FrameRD_0_M_AXIS_0_m_axis_tuser;
wire          FrameRD_0_M_AXIS_0_m_axis_tvalid;
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
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                  = 1'b0;
assign s_axis_tdata_const_net_0 = 8'h00;
assign s_axis_tuser_const_net_0 = 4'h0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------axis_save_ppm
axis_save_ppm axis_save_ppm_0(
        // Inputs
        .aclk          ( CLK_GEN_PIXCLK_0_CLK ),
        .aresetn       ( RESET_GEN_C0_0_RESET ),
        .s_axis_tdata  ( FrameRD_0_M_AXIS_0_m_axis_tdata ),
        .s_axis_tvalid ( FrameRD_0_M_AXIS_0_m_axis_tvalid ),
        .s_axis_tlast  ( FrameRD_0_M_AXIS_0_m_axis_tlast ),
        .s_axis_tuser  ( FrameRD_0_M_AXIS_0_m_axis_tuser ),
        // Outputs
        .s_axis_tready ( axis_save_ppm_0_s_axis_tready ) 
        );

//--------axis_save_pgm2
axis_save_pgm2 axis_video_to_pgm_0(
        // Inputs
        .aclk          ( GND_net ),
        .aresetn       ( GND_net ),
        .s_axis_tdata  ( s_axis_tdata_const_net_0 ),
        .s_axis_tvalid ( GND_net ),
        .s_axis_tlast  ( GND_net ),
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
        .rstn_i                 ( RESET_GEN_C0_0_RESET ),
        .video_clk              ( VideoClock_CLK ),
        .ddr_clk_i              ( DDR_CLK_0_CLK ),
        .pixel_clk              ( CLK_GEN_PIXCLK_0_CLK ),
        .TREADY_I               ( RDYCTRL_0_oRdy ),
        .M_AXIS_0_m_axis_tready ( axis_save_ppm_0_s_axis_tready ),
        // Outputs
        .M_AXIS_0_m_axis_tvalid ( FrameRD_0_M_AXIS_0_m_axis_tvalid ),
        .M_AXIS_0_m_axis_tdata  ( FrameRD_0_M_AXIS_0_m_axis_tdata ),
        .M_AXIS_0_m_axis_tlast  ( FrameRD_0_M_AXIS_0_m_axis_tlast ),
        .M_AXIS_0_m_axis_tuser  ( FrameRD_0_M_AXIS_0_m_axis_tuser ) 
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
