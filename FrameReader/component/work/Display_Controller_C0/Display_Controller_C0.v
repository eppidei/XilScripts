//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Jan 23 21:00:50 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of Display_Controller_C0 to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component Display_Controller_C0
create_and_configure_core -core_vlnv {Microchip:SolutionCore:Display_Controller:5.0.0} -component_name {Display_Controller_C0} -params {\
"g_AXI4STREAM_INTERFACE:0"  \
"g_CONFIGURATION_INTERFACE:0"  \
"g_ENABLE_EXT_SYNC:0"  \
"g_HSYNC_POLARITY:0"  \
"g_PIXELS_DATA_WIDTH:24"  \
"g_PIXELS_PER_CLK:1"  \
"g_STROBE_EN:0"  \
"g_VIDEO_DISPLAY_METHOD:0"  \
"g_VIDEO_RESOLUTION:1"  \
"g_VIDEO_TIMINGS:0"  \
"g_VSYNC_POLARITY:0"   }
# Exporting Component Description of Display_Controller_C0 to TCL done
*/

// Display_Controller_C0
module Display_Controller_C0(
    // Inputs
    ENABLE_I,
    RESETN_I,
    SYS_CLK_I,
    // Outputs
    DATA_TRIGGER_O,
    FRAME_END_O,
    H_RES_O,
    H_SYNC_O,
    V_ACTIVE_O,
    V_RES_O,
    V_SYNC_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ENABLE_I;
input         RESETN_I;
input         SYS_CLK_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [0:0]  DATA_TRIGGER_O;
output        FRAME_END_O;
output [15:0] H_RES_O;
output [0:0]  H_SYNC_O;
output        V_ACTIVE_O;
output [15:0] V_RES_O;
output        V_SYNC_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [0:0]  DATA_TRIGGER_O_net_0;
wire          ENABLE_I;
wire          FRAME_END_O_net_0;
wire   [15:0] H_RES_O_net_0;
wire   [0:0]  H_SYNC_O_net_0;
wire          RESETN_I;
wire          SYS_CLK_I;
wire          V_ACTIVE_O_net_0;
wire   [15:0] V_RES_O_net_0;
wire          V_SYNC_O_net_0;
wire          FRAME_END_O_net_1;
wire          V_SYNC_O_net_1;
wire          V_ACTIVE_O_net_1;
wire   [0:0]  H_SYNC_O_net_1;
wire   [0:0]  DATA_TRIGGER_O_net_1;
wire   [15:0] H_RES_O_net_1;
wire   [15:0] V_RES_O_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [15:0] H_RESOLUTION_I_const_net_0;
wire   [15:0] V_RESOLUTION_I_const_net_0;
wire   [15:0] H_F_PORCH_I_const_net_0;
wire   [15:0] H_B_PORCH_I_const_net_0;
wire   [15:0] H_SYNC_WIDTH_I_const_net_0;
wire   [15:0] V_F_PORCH_I_const_net_0;
wire   [15:0] V_F_PORCH_I1_const_net_0;
wire   [15:0] V_F_PORCH_I2_const_net_0;
wire   [15:0] V_B_PORCH_I_const_net_0;
wire   [15:0] V_B_PORCH_I1_const_net_0;
wire   [15:0] V_B_PORCH_I2_const_net_0;
wire   [15:0] V_SYNC_WIDTH_I_const_net_0;
wire   [15:0] V_SYNC_WIDTH_I1_const_net_0;
wire   [15:0] V_SYNC_WIDTH_I2_const_net_0;
wire   [23:0] DATA_I_const_net_0;
wire   [23:0] TDATA_I_const_net_0;
wire   [31:0] awaddr_const_net_0;
wire   [31:0] wdata_const_net_0;
wire   [31:0] araddr_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                     = 1'b0;
assign H_RESOLUTION_I_const_net_0  = 16'h0000;
assign V_RESOLUTION_I_const_net_0  = 16'h0000;
assign H_F_PORCH_I_const_net_0     = 16'h0000;
assign H_B_PORCH_I_const_net_0     = 16'h0000;
assign H_SYNC_WIDTH_I_const_net_0  = 16'h0000;
assign V_F_PORCH_I_const_net_0     = 16'h0000;
assign V_F_PORCH_I1_const_net_0    = 16'h0000;
assign V_F_PORCH_I2_const_net_0    = 16'h0000;
assign V_B_PORCH_I_const_net_0     = 16'h0000;
assign V_B_PORCH_I1_const_net_0    = 16'h0000;
assign V_B_PORCH_I2_const_net_0    = 16'h0000;
assign V_SYNC_WIDTH_I_const_net_0  = 16'h0000;
assign V_SYNC_WIDTH_I1_const_net_0 = 16'h0000;
assign V_SYNC_WIDTH_I2_const_net_0 = 16'h0000;
assign DATA_I_const_net_0          = 24'h000000;
assign TDATA_I_const_net_0         = 24'h000000;
assign awaddr_const_net_0          = 32'h00000000;
assign wdata_const_net_0           = 32'h00000000;
assign araddr_const_net_0          = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FRAME_END_O_net_1       = FRAME_END_O_net_0;
assign FRAME_END_O             = FRAME_END_O_net_1;
assign V_SYNC_O_net_1          = V_SYNC_O_net_0;
assign V_SYNC_O                = V_SYNC_O_net_1;
assign V_ACTIVE_O_net_1        = V_ACTIVE_O_net_0;
assign V_ACTIVE_O              = V_ACTIVE_O_net_1;
assign H_SYNC_O_net_1[0]       = H_SYNC_O_net_0[0];
assign H_SYNC_O[0:0]           = H_SYNC_O_net_1[0];
assign DATA_TRIGGER_O_net_1[0] = DATA_TRIGGER_O_net_0[0];
assign DATA_TRIGGER_O[0:0]     = DATA_TRIGGER_O_net_1[0];
assign H_RES_O_net_1           = H_RES_O_net_0;
assign H_RES_O[15:0]           = H_RES_O_net_1;
assign V_RES_O_net_1           = V_RES_O_net_0;
assign V_RES_O[15:0]           = V_RES_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------Display_Controller   -   Microchip:SolutionCore:Display_Controller:5.0.0
Display_Controller #( 
        .g_AXI4STREAM_INTERFACE    ( 0 ),
        .g_CONFIGURATION_INTERFACE ( 0 ),
        .g_ENABLE_EXT_SYNC         ( 0 ),
        .g_HSYNC_POLARITY          ( 0 ),
        .g_PIXELS_DATA_WIDTH       ( 24 ),
        .g_PIXELS_PER_CLK          ( 1 ),
        .g_STROBE_EN               ( 0 ),
        .g_VIDEO_DISPLAY_METHOD    ( 0 ),
        .g_VIDEO_RESOLUTION        ( 1 ),
        .g_VIDEO_TIMINGS           ( 0 ),
        .g_VSYNC_POLARITY          ( 0 ) )
Display_Controller_C0_0(
        // Inputs
        .AXI4L_RESETN_I    ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_CLK_I       ( GND_net ), // tied to 1'b0 from definition
        .awvalid           ( GND_net ), // tied to 1'b0 from definition
        .wvalid            ( GND_net ), // tied to 1'b0 from definition
        .bready            ( GND_net ), // tied to 1'b0 from definition
        .arvalid           ( GND_net ), // tied to 1'b0 from definition
        .rready            ( GND_net ), // tied to 1'b0 from definition
        .RESETN_I          ( RESETN_I ),
        .SYS_CLK_I         ( SYS_CLK_I ),
        .ENABLE_I          ( ENABLE_I ),
        .EXT_SYNC_SIGNAL_I ( GND_net ), // tied to 1'b0 from definition
        .TVALID_I          ( GND_net ), // tied to 1'b0 from definition
        .awaddr            ( awaddr_const_net_0 ), // tied to 32'h00000000 from definition
        .wdata             ( wdata_const_net_0 ), // tied to 32'h00000000 from definition
        .araddr            ( araddr_const_net_0 ), // tied to 32'h00000000 from definition
        .H_RESOLUTION_I    ( H_RESOLUTION_I_const_net_0 ), // tied to 16'h0000 from definition
        .V_RESOLUTION_I    ( V_RESOLUTION_I_const_net_0 ), // tied to 16'h0000 from definition
        .H_F_PORCH_I       ( H_F_PORCH_I_const_net_0 ), // tied to 16'h0000 from definition
        .H_B_PORCH_I       ( H_B_PORCH_I_const_net_0 ), // tied to 16'h0000 from definition
        .H_SYNC_WIDTH_I    ( H_SYNC_WIDTH_I_const_net_0 ), // tied to 16'h0000 from definition
        .V_F_PORCH_I       ( V_F_PORCH_I_const_net_0 ), // tied to 16'h0000 from definition
        .V_F_PORCH_I1      ( V_F_PORCH_I1_const_net_0 ), // tied to 16'h0000 from definition
        .V_F_PORCH_I2      ( V_F_PORCH_I2_const_net_0 ), // tied to 16'h0000 from definition
        .V_B_PORCH_I       ( V_B_PORCH_I_const_net_0 ), // tied to 16'h0000 from definition
        .V_B_PORCH_I1      ( V_B_PORCH_I1_const_net_0 ), // tied to 16'h0000 from definition
        .V_B_PORCH_I2      ( V_B_PORCH_I2_const_net_0 ), // tied to 16'h0000 from definition
        .V_SYNC_WIDTH_I    ( V_SYNC_WIDTH_I_const_net_0 ), // tied to 16'h0000 from definition
        .V_SYNC_WIDTH_I1   ( V_SYNC_WIDTH_I1_const_net_0 ), // tied to 16'h0000 from definition
        .V_SYNC_WIDTH_I2   ( V_SYNC_WIDTH_I2_const_net_0 ), // tied to 16'h0000 from definition
        .DATA_I            ( DATA_I_const_net_0 ), // tied to 24'h000000 from definition
        .TDATA_I           ( TDATA_I_const_net_0 ), // tied to 24'h000000 from definition
        // Outputs
        .awready           (  ),
        .wready            (  ),
        .bvalid            (  ),
        .arready           (  ),
        .rvalid            (  ),
        .TREADY_O          (  ),
        .FRAME_END_O       ( FRAME_END_O_net_0 ),
        .V_SYNC_O          ( V_SYNC_O_net_0 ),
        .V_ACTIVE_O        ( V_ACTIVE_O_net_0 ),
        .TLAST_O           (  ),
        .TVALID_O          (  ),
        .bresp             (  ),
        .rdata             (  ),
        .rresp             (  ),
        .H_SYNC_O          ( H_SYNC_O_net_0 ),
        .DATA_TRIGGER_O    ( DATA_TRIGGER_O_net_0 ),
        .DATA_VALID_O      (  ),
        .H_RES_O           ( H_RES_O_net_0 ),
        .V_RES_O           ( V_RES_O_net_0 ),
        .DATA_O            (  ),
        .TDATA_O           (  ),
        .TUSER_O           (  ),
        .TSTRB_O           (  ),
        .TKEEP_O           (  ) 
        );


endmodule
