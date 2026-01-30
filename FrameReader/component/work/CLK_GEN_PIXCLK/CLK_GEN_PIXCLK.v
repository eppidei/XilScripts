//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Jan 29 23:43:04 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of CLK_GEN_PIXCLK to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component CLK_GEN_PIXCLK
create_and_configure_core -core_vlnv {Actel:Simulation:CLK_GEN:1.0.1} -component_name {CLK_GEN_PIXCLK} -params {\
"CLK_PERIOD:5000"  \
"DUTY_CYCLE:50"   }
# Exporting Component Description of CLK_GEN_PIXCLK to TCL done
*/

// CLK_GEN_PIXCLK
module CLK_GEN_PIXCLK(
    // Outputs
    CLK
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output CLK;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   CLK_net_0;
wire   CLK_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CLK_net_1 = CLK_net_0;
assign CLK       = CLK_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CLK_GEN   -   Actel:Simulation:CLK_GEN:1.0.1
CLK_GEN #( 
        .CLK_PERIOD ( 5000 ),
        .DUTY_CYCLE ( 50 ) )
CLK_GEN_PIXCLK_0(
        // Outputs
        .CLK ( CLK_net_0 ) 
        );


endmodule
