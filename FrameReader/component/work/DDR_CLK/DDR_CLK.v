//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Jan 26 00:59:19 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of DDR_CLK to TCL
# Family: PolarFire
# Part Number: MPF100T-1FCSG325I
# Create and Configure the core component DDR_CLK
create_and_configure_core -core_vlnv {Actel:Simulation:CLK_GEN:1.0.1} -component_name {DDR_CLK} -params {\
"CLK_PERIOD:2500"  \
"DUTY_CYCLE:50"   }
# Exporting Component Description of DDR_CLK to TCL done
*/

// DDR_CLK
module DDR_CLK(
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
        .CLK_PERIOD ( 2500 ),
        .DUTY_CYCLE ( 50 ) )
DDR_CLK_0(
        // Outputs
        .CLK ( CLK_net_0 ) 
        );


endmodule
