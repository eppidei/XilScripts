//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Jan 24 08:59:28 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of RESET_GEN_C0 to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component RESET_GEN_C0
create_and_configure_core -core_vlnv {Actel:Simulation:RESET_GEN:1.0.1} -component_name {RESET_GEN_C0} -params {\
"DELAY:1000"  \
"LOGIC_LEVEL:0"   }
# Exporting Component Description of RESET_GEN_C0 to TCL done
*/

// RESET_GEN_C0
module RESET_GEN_C0(
    // Outputs
    RESET
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output RESET;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   RESET_net_0;
wire   RESET_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign RESET_net_1 = RESET_net_0;
assign RESET       = RESET_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------RESET_GEN   -   Actel:Simulation:RESET_GEN:1.0.1
RESET_GEN #( 
        .DELAY       ( 1000 ),
        .LOGIC_LEVEL ( 0 ) )
RESET_GEN_C0_0(
        // Outputs
        .RESET ( RESET_net_0 ) 
        );


endmodule
