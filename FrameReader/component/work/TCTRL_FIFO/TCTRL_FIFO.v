//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Feb 24 01:06:41 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of TCTRL_FIFO to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component TCTRL_FIFO
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFIFO:3.1.101} -component_name {TCTRL_FIFO} -params {\
"AE_STATIC_EN:false"  \
"AEVAL:4"  \
"AF_STATIC_EN:false"  \
"AFVAL:1020"  \
"CTRL_TYPE:2"  \
"DIE_SIZE:5"  \
"ECC:0"  \
"ESTOP:true"  \
"FSTOP:true"  \
"FWFT:false"  \
"NUM_STAGES:2"  \
"OVERFLOW_EN:false"  \
"PIPE:1"  \
"PREFETCH:false"  \
"RAM_OPT:0"  \
"RDCNT_EN:false"  \
"RDEPTH:2048"  \
"RE_POLARITY:0"  \
"READ_DVALID:true"  \
"RWIDTH:24"  \
"SYNC:0"  \
"SYNC_RESET:1"  \
"UNDERFLOW_EN:false"  \
"WDEPTH:2048"  \
"WE_POLARITY:0"  \
"WRCNT_EN:false"  \
"WRITE_ACK:false"  \
"WWIDTH:24"   }
# Exporting Component Description of TCTRL_FIFO to TCL done
*/

// TCTRL_FIFO
module TCTRL_FIFO(
    // Inputs
    DATA,
    RCLOCK,
    RE,
    RRESET_N,
    WCLOCK,
    WE,
    WRESET_N,
    // Outputs
    DVLD,
    EMPTY,
    FULL,
    Q
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [23:0] DATA;
input         RCLOCK;
input         RE;
input         RRESET_N;
input         WCLOCK;
input         WE;
input         WRESET_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        DVLD;
output        EMPTY;
output        FULL;
output [23:0] Q;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [23:0] DATA;
wire          DVLD_net_0;
wire          EMPTY_net_0;
wire          FULL_net_0;
wire   [23:0] Q_net_0;
wire          RCLOCK;
wire          RE;
wire          RRESET_N;
wire          WCLOCK;
wire          WE;
wire          WRESET_N;
wire   [23:0] Q_net_1;
wire          FULL_net_1;
wire          EMPTY_net_1;
wire          DVLD_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [23:0] MEMRD_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net           = 1'b0;
assign MEMRD_const_net_0 = 24'h000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign Q_net_1     = Q_net_0;
assign Q[23:0]     = Q_net_1;
assign FULL_net_1  = FULL_net_0;
assign FULL        = FULL_net_1;
assign EMPTY_net_1 = EMPTY_net_0;
assign EMPTY       = EMPTY_net_1;
assign DVLD_net_1  = DVLD_net_0;
assign DVLD        = DVLD_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------TCTRL_FIFO_TCTRL_FIFO_0_COREFIFO   -   Actel:DirectCore:COREFIFO:3.1.101
TCTRL_FIFO_TCTRL_FIFO_0_COREFIFO #( 
        .AE_STATIC_EN ( 0 ),
        .AEVAL        ( 4 ),
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
        .RDCNT_EN     ( 0 ),
        .RDEPTH       ( 2048 ),
        .RE_POLARITY  ( 0 ),
        .READ_DVALID  ( 1 ),
        .RWIDTH       ( 24 ),
        .SYNC         ( 0 ),
        .SYNC_RESET   ( 1 ),
        .UNDERFLOW_EN ( 0 ),
        .WDEPTH       ( 2048 ),
        .WE_POLARITY  ( 0 ),
        .WRCNT_EN     ( 0 ),
        .WRITE_ACK    ( 0 ),
        .WWIDTH       ( 24 ) )
TCTRL_FIFO_0(
        // Inputs
        .CLK        ( GND_net ), // tied to 1'b0 from definition
        .WCLOCK     ( WCLOCK ),
        .RCLOCK     ( RCLOCK ),
        .RESET_N    ( GND_net ), // tied to 1'b0 from definition
        .WRESET_N   ( WRESET_N ),
        .RRESET_N   ( RRESET_N ),
        .DATA       ( DATA ),
        .WE         ( WE ),
        .RE         ( RE ),
        .MEMRD      ( MEMRD_const_net_0 ), // tied to 24'h000000 from definition
        // Outputs
        .Q          ( Q_net_0 ),
        .FULL       ( FULL_net_0 ),
        .EMPTY      ( EMPTY_net_0 ),
        .AFULL      (  ),
        .AEMPTY     (  ),
        .OVERFLOW   (  ),
        .UNDERFLOW  (  ),
        .WACK       (  ),
        .DVLD       ( DVLD_net_0 ),
        .WRCNT      (  ),
        .RDCNT      (  ),
        .MEMWE      (  ),
        .MEMRE      (  ),
        .MEMWADDR   (  ),
        .MEMRADDR   (  ),
        .MEMWD      (  ),
        .SB_CORRECT (  ),
        .DB_DETECT  (  ) 
        );


endmodule
