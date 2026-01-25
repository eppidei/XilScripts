//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Jan 26 01:34:46 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD
module FrameRD(
    // Inputs
    TREADY_I,
    ddr_clk_i,
    pixel_clk_i,
    rstn_i
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  TREADY_I;
input  ddr_clk_i;
input  pixel_clk_i;
input  rstn_i;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AND2_0_Y;
wire          DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0;
wire   [31:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARCACHE;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLOCK;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARPROT;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID;
wire   [31:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWCACHE;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLOCK;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWPROT;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID;
wire   [63:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID;
wire   [63:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID;
wire   [63:0] DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0;
wire          ddr_clk_i;
wire   [31:0] DDR_Read_0_ARADDR_O;
wire   [7:0]  DDR_Read_0_ARSIZE_O;
wire          DDR_Read_0_ARVALID_O;
wire          DFN1_0_Q;
wire   [15:0] Display_Controller_C0_0_H_RES_O;
wire          Display_Controller_C0_0_V_ACTIVE_O;
wire   [15:0] Display_Controller_C0_0_V_RES_O;
wire          pixel_clk_i;
wire          rstn_i;
wire          TREADY_I;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire   [15:0] line_gap_i_const_net_0;
wire   [7:0]  frame_start_addr_i_const_net_0;
wire   [11:0] h_offset_i_const_net_0;
wire   [11:0] v_offset_i_const_net_0;
wire   [31:0] AWADDR_I_0_const_net_0;
wire   [7:0]  AWSIZE_I_0_const_net_0;
wire          GND_net;
wire   [63:0] WDATA_I_0_const_net_0;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire          B_IN_POST_INV0_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_3to0;
wire   [7:4]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_7to4;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_3to0;
wire   [7:4]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_7to4;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0_3to0;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0_3to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                        = 1'b1;
assign line_gap_i_const_net_0         = 16'h1000;
assign frame_start_addr_i_const_net_0 = 8'h00;
assign h_offset_i_const_net_0         = 12'h000;
assign v_offset_i_const_net_0         = 12'h000;
assign AWADDR_I_0_const_net_0         = 32'h00000000;
assign AWSIZE_I_0_const_net_0         = 8'h00;
assign GND_net                        = 1'b0;
assign WDATA_I_0_const_net_0          = 64'h0000000000000000;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign B_IN_POST_INV0_0 = ~ DFN1_0_Q;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0 = { DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_7to4, DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_3to0 };
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_3to0 = DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID[3:0];
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0_7to4 = 4'h0;

assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0 = { DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_7to4, DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_3to0 };
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_3to0 = DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID[3:0];
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0_7to4 = 4'h0;

assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0 = { DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0_3to0 };
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0_3to0 = DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID[3:0];

assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0 = { DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0_3to0 };
assign DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0_3to0 = DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID[3:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( Display_Controller_C0_0_V_ACTIVE_O ),
        .B ( B_IN_POST_INV0_0 ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------DDR_AXI4_ARBITER_PF_C0
DDR_AXI4_ARBITER_PF_C0 DDR_AXI4_ARBITER_PF_C0_0(
        // Inputs
        .reset_i          ( rstn_i ),
        .sys_clk_i        ( ddr_clk_i ),
        .ddr_ctrl_ready_i ( VCC_net ),
        .awready          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY ),
        .wready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY ),
        .bvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID ),
        .arready          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY ),
        .rlast            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST ),
        .rvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID ),
        .AWVALID_I_0      ( GND_net ), // tied to 1'b0 from definition
        .WVALID_I_0       ( GND_net ), // tied to 1'b0 from definition
        .ARVALID_I_0      ( DDR_Read_0_ARVALID_O ),
        .bid              ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID_0 ),
        .bresp            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .rid              ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID_0 ),
        .rdata            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA ),
        .rresp            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP ),
        .AWADDR_I_0       ( AWADDR_I_0_const_net_0 ), // tied to 32'h00000000 from definition
        .AWSIZE_I_0       ( AWSIZE_I_0_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_0        ( WDATA_I_0_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .ARADDR_I_0       ( DDR_Read_0_ARADDR_O ),
        .ARSIZE_I_0       ( DDR_Read_0_ARSIZE_O ),
        // Outputs
        .awvalid          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID ),
        .wlast            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST ),
        .wvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID ),
        .bready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY ),
        .arvalid          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID ),
        .rready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY ),
        .AWREADY_O_0      (  ),
        .BUSER_O_0        (  ),
        .ARREADY_O_0      ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0 ),
        .RLAST_O_0        (  ),
        .RVALID_O_0       ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0 ),
        .BUSER_O_r0       ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0 ),
        .awid             ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID ),
        .awaddr           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR ),
        .awlen            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN ),
        .awsize           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE ),
        .awburst          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST ),
        .awlock           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLOCK ),
        .awcache          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWCACHE ),
        .awprot           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWPROT ),
        .wdata            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA ),
        .wstrb            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB ),
        .arid             ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID ),
        .araddr           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR ),
        .arlen            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN ),
        .arsize           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE ),
        .arburst          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST ),
        .arlock           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLOCK ),
        .arcache          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARCACHE ),
        .arprot           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARPROT ),
        .RDATA_O_0        ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_0 ) 
        );

//--------DDR_Read
DDR_Read #( 
        .g_AXI4S_FORMAT         ( 1 ),
        .g_DDR_AXI_AWIDTH       ( 32 ),
        .g_DDR_AXI_DWIDTH_I     ( 64 ),
        .g_FORMAT               ( 1 ),
        .g_FRAME_GAP            ( 0 ),
        .g_MAX_HORIZ_RESOL      ( 1920 ),
        .g_NO_OF_PIXEL_STREAMED ( 1 ),
        .g_PIXEL_WIDTH          ( 8 ) )
DDR_Read_0(
        // Inputs
        .reset_i            ( rstn_i ),
        .pixel_clk_i        ( pixel_clk_i ),
        .ddr_clk_i          ( ddr_clk_i ),
        .line_gap_i         ( line_gap_i_const_net_0 ),
        .horz_resl_i        ( Display_Controller_C0_0_H_RES_O ),
        .vert_resl_i        ( Display_Controller_C0_0_V_RES_O ),
        .frame_start_i      ( AND2_0_Y ),
        .frame_start_addr_i ( frame_start_addr_i_const_net_0 ),
        .h_offset_i         ( h_offset_i_const_net_0 ),
        .v_offset_i         ( v_offset_i_const_net_0 ),
        .RDATA_I            ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_0 ),
        .RVALID_I           ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0 ),
        .ARREADY_I          ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0 ),
        .BUSER_I            ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0 ),
        .TREADY_I           ( TREADY_I ),
        // Outputs
        .ARADDR_O           ( DDR_Read_0_ARADDR_O ),
        .ARVALID_O          ( DDR_Read_0_ARVALID_O ),
        .ARSIZE_O           ( DDR_Read_0_ARSIZE_O ),
        .read_start_addr_o  (  ),
        .read_req_o         (  ),
        .burst_size_o       (  ),
        .TDATA_O            (  ),
        .TSTRB_O            (  ),
        .TKEEP_O            (  ),
        .TVALID_O           (  ),
        .TLAST_O            (  ),
        .TUSER_O            (  ) 
        );

//--------DFN1
DFN1 DFN1_0(
        // Inputs
        .D   ( Display_Controller_C0_0_V_ACTIVE_O ),
        .CLK ( pixel_clk_i ),
        // Outputs
        .Q   ( DFN1_0_Q ) 
        );

//--------Display_Controller_C0
Display_Controller_C0 Display_Controller_C0_0(
        // Inputs
        .RESETN_I       ( rstn_i ),
        .SYS_CLK_I      ( pixel_clk_i ),
        .ENABLE_I       ( rstn_i ),
        // Outputs
        .FRAME_END_O    (  ),
        .V_SYNC_O       (  ),
        .V_ACTIVE_O     ( Display_Controller_C0_0_V_ACTIVE_O ),
        .H_SYNC_O       (  ),
        .DATA_TRIGGER_O (  ),
        .H_RES_O        ( Display_Controller_C0_0_H_RES_O ),
        .V_RES_O        ( Display_Controller_C0_0_V_RES_O ) 
        );

//--------PF_SRAM_AHBL_AXI_C0
PF_SRAM_AHBL_AXI_C0 PF_SRAM_AHBL_AXI_C0_0(
        // Inputs
        .ACLK    ( ddr_clk_i ),
        .ARESETN ( rstn_i ),
        .AWVALID ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID ),
        .WLAST   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST ),
        .WVALID  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID ),
        .BREADY  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY ),
        .ARVALID ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID ),
        .RREADY  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY ),
        .AWADDR  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR ),
        .AWLEN   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN ),
        .AWSIZE  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE ),
        .AWBURST ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST ),
        .AWLOCK  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLOCK ),
        .AWCACHE ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWCACHE ),
        .AWPROT  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWPROT ),
        .WDATA   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA ),
        .WSTRB   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB ),
        .ARADDR  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR ),
        .ARLEN   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN ),
        .ARSIZE  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE ),
        .ARBURST ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST ),
        .ARLOCK  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLOCK ),
        .ARCACHE ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARCACHE ),
        .ARPROT  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARPROT ),
        .AWID    ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID_0 ),
        .ARID    ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID_0 ),
        // Outputs
        .AWREADY ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY ),
        .WREADY  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY ),
        .BVALID  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID ),
        .ARREADY ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY ),
        .RLAST   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST ),
        .RVALID  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID ),
        .RDATA   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA ),
        .RRESP   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP ),
        .BRESP   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .BID     ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BID ),
        .RID     ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RID ) 
        );


endmodule
