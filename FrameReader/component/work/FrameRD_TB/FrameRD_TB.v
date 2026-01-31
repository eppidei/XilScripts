//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Jan 31 18:59:00 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD_TB
module FrameRD_TB(
);

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   CLK_GEN_PIXCLK_0_CLK;
wire   DDR_CLK_0_CLK;
wire   PixelClock_CLK;
wire   RDYCTRL_0_oRdy;
wire   RESET_GEN_C0_0_RESET;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
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
        .rstn_i    ( RESET_GEN_C0_0_RESET ),
        .video_clk ( PixelClock_CLK ),
        .ddr_clk_i ( DDR_CLK_0_CLK ),
        .pixel_clk ( CLK_GEN_PIXCLK_0_CLK ),
        .TREADY_I  ( RDYCTRL_0_oRdy ) 
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
        .CLK ( PixelClock_CLK ) 
        );


endmodule
