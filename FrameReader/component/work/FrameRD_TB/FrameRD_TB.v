//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Jan 26 00:59:24 2026
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
wire   RESET_GEN_C0_0_RESET;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
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
        .TREADY_I    ( VCC_net ) 
        );

//--------CLK_GEN_C0
CLK_GEN_C0 PixelClock(
        // Outputs
        .CLK ( PixelClock_CLK ) 
        );

//--------PULSE_GEN_C0
PULSE_GEN_C0 PULSE_GEN_C0_0(
        // Outputs
        .PULSE (  ) 
        );

//--------RESET_GEN_C0
RESET_GEN_C0 RESET_GEN_C0_0(
        // Outputs
        .RESET ( RESET_GEN_C0_0_RESET ) 
        );


endmodule
