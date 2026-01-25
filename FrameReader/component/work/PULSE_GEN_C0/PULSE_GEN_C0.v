//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jan 25 10:30:39 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PULSE_GEN_C0 to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component PULSE_GEN_C0
create_and_configure_core -core_vlnv {Actel:Simulation:PULSE_GEN:1.0.1} -component_name {PULSE_GEN_C0} -params {\
"PULSE_START_TIME:1000"  \
"PULSE_TYPE:1"  \
"PULSE_WIDTH:1000"   }
# Exporting Component Description of PULSE_GEN_C0 to TCL done
*/

// PULSE_GEN_C0
module PULSE_GEN_C0(
    // Outputs
    PULSE
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output PULSE;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   PULSE_net_0;
wire   PULSE_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign PULSE_net_1 = PULSE_net_0;
assign PULSE       = PULSE_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PULSE_GEN   -   Actel:Simulation:PULSE_GEN:1.0.1
PULSE_GEN #( 
        .PULSE_START_TIME ( 1000 ),
        .PULSE_TYPE       ( 1 ),
        .PULSE_WIDTH      ( 1000 ) )
PULSE_GEN_C0_0(
        // Outputs
        .PULSE ( PULSE_net_0 ) 
        );


endmodule
