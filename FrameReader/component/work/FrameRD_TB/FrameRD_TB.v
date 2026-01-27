//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jan 27 23:23:24 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD_TB
module FrameRD_TB(
);

//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   DDR_CLK_0_CLK;
wire   PixelClock_CLK;
wire   RDYCTRL_0_oRdy;
wire   RESET_GEN_C0_0_RESET;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DDR_CLK
DDR_CLK DDR_CLK_0(
        // Outputs
        .CLK ( DDR_CLK_0_CLK ) 
        );

//--------FrameRD
FrameRD FrameRD_0(
        // Inputs
        .rstn_i      ( RESET_GEN_C0_0_RESET ),
        .pixel_clk_i ( PixelClock_CLK ),
        .ddr_clk_i   ( DDR_CLK_0_CLK ),
        .m_ready     ( RDYCTRL_0_oRdy ) 
        );

//--------CLK_GEN_C0
CLK_GEN_C0 PixelClock(
        // Outputs
        .CLK ( PixelClock_CLK ) 
        );

//--------RDYCTRL
RDYCTRL RDYCTRL_0(
        // Inputs
        .iCLK  ( PixelClock_CLK ),
        .iRSTN ( RESET_GEN_C0_0_RESET ),
        // Outputs
        .oRdy  ( RDYCTRL_0_oRdy ) 
        );

//--------RESET_GEN_C0
RESET_GEN_C0 RESET_GEN_C0_0(
        // Outputs
        .RESET ( RESET_GEN_C0_0_RESET ) 
        );


endmodule
