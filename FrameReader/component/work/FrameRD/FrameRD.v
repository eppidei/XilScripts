//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Feb  1 22:50:57 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD
module FrameRD(
    // Inputs
    M_AXIS_0_m_axis_tready,
    TREADY_I,
    ddr_clk_i,
    pixel_clk,
    rstn_i,
    video_clk,
    // Outputs
    M_AXIS_0_m_axis_tdata,
    M_AXIS_0_m_axis_tlast,
    M_AXIS_0_m_axis_tuser,
    M_AXIS_0_m_axis_tvalid
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         M_AXIS_0_m_axis_tready;
input         TREADY_I;
input         ddr_clk_i;
input         pixel_clk;
input         rstn_i;
input         video_clk;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [23:0] M_AXIS_0_m_axis_tdata;
output        M_AXIS_0_m_axis_tlast;
output [3:0]  M_AXIS_0_m_axis_tuser;
output        M_AXIS_0_m_axis_tvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AND2_0_Y_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0;
wire   [31:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARCACHE;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID;
wire   [7:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLOCK;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARPROT;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY;
wire   [2:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE;
wire          DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID;
wire   [31:0] DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR;
wire   [1:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWCACHE;
wire   [3:0]  DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID;
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
wire   [7:0]  DDR_Read_0_AXIS_M_TDATA;
wire   [0:0]  DDR_Read_0_AXIS_M_TKEEP;
wire          DDR_Read_0_AXIS_M_TLAST;
wire          DDR_Read_0_AXIS_M_TREADY;
wire   [0:0]  DDR_Read_0_AXIS_M_TSTRB;
wire   [3:0]  DDR_Read_0_AXIS_M_TUSER;
wire          DDR_Read_0_AXIS_M_TVALID;
wire          DFN1_0_0_Q;
wire          DFN1_0_Q;
wire          Display_Controller_C0_0_V_ACTIVE_O;
wire   [23:0] M_AXIS_0_TDATA;
wire          M_AXIS_0_TLAST;
wire          M_AXIS_0_m_axis_tready;
wire   [3:0]  M_AXIS_0_TUSER;
wire          M_AXIS_0_TVALID;
wire          pixel_clk;
wire          rstn_i;
wire          TREADY_I;
wire          video_clk;
wire          M_AXIS_0_TVALID_net_0;
wire   [23:0] M_AXIS_0_TDATA_net_0;
wire          M_AXIS_0_TLAST_net_0;
wire   [3:0]  M_AXIS_0_TUSER_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [11:0] cfg_img_width_const_net_0;
wire          VCC_net;
wire   [15:0] line_gap_i_const_net_0;
wire   [15:0] horz_resl_i_const_net_0;
wire   [15:0] vert_resl_i_const_net_0;
wire   [7:0]  frame_start_addr_i_const_net_0;
wire   [11:0] h_offset_i_const_net_0;
wire   [11:0] v_offset_i_const_net_0;
wire          GND_net;
wire   [23:0] dIn_const_net_0;
wire   [7:0]  inputDiscardCnt_const_net_0;
wire   [15:0] inputXRes_const_net_0;
wire   [15:0] inputYRes_const_net_0;
wire   [15:0] outputXRes_const_net_0;
wire   [15:0] outputYRes_const_net_0;
wire   [17:0] xScale_const_net_0;
wire   [17:0] yScale_const_net_0;
wire   [29:0] leftOffset_const_net_0;
wire   [13:0] topFracOffset_const_net_0;
wire   [3:0]  bid_const_net_0;
wire   [3:0]  rid_const_net_0;
wire   [31:0] AWADDR_I_0_const_net_0;
wire   [7:0]  AWSIZE_I_0_const_net_0;
wire   [63:0] WDATA_I_0_const_net_0;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire          B_IN_POST_INV0_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign cfg_img_width_const_net_0      = 12'h190;
assign VCC_net                        = 1'b1;
assign line_gap_i_const_net_0         = 16'h1000;
assign horz_resl_i_const_net_0        = 16'h0190;
assign vert_resl_i_const_net_0        = 16'h012C;
assign frame_start_addr_i_const_net_0 = 8'h00;
assign h_offset_i_const_net_0         = 12'h0C0;
assign v_offset_i_const_net_0         = 12'h0C8;
assign GND_net                        = 1'b0;
assign dIn_const_net_0                = 24'h000000;
assign inputDiscardCnt_const_net_0    = 8'h00;
assign inputXRes_const_net_0          = 16'h01E0;
assign inputYRes_const_net_0          = 16'h010E;
assign outputXRes_const_net_0         = 16'h0780;
assign outputYRes_const_net_0         = 16'h0438;
assign xScale_const_net_0             = 18'h01000;
assign yScale_const_net_0             = 18'h01000;
assign leftOffset_const_net_0         = 30'h00000000;
assign topFracOffset_const_net_0      = 14'h0000;
assign bid_const_net_0                = 4'h0;
assign rid_const_net_0                = 4'h0;
assign AWADDR_I_0_const_net_0         = 32'h00000000;
assign AWSIZE_I_0_const_net_0         = 8'h00;
assign WDATA_I_0_const_net_0          = 64'h0000000000000000;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign B_IN_POST_INV0_0 = ~ DFN1_0_0_Q;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign M_AXIS_0_TVALID_net_0       = M_AXIS_0_TVALID;
assign M_AXIS_0_m_axis_tvalid      = M_AXIS_0_TVALID_net_0;
assign M_AXIS_0_TDATA_net_0        = M_AXIS_0_TDATA;
assign M_AXIS_0_m_axis_tdata[23:0] = M_AXIS_0_TDATA_net_0;
assign M_AXIS_0_TLAST_net_0        = M_AXIS_0_TLAST;
assign M_AXIS_0_m_axis_tlast       = M_AXIS_0_TLAST_net_0;
assign M_AXIS_0_TUSER_net_0        = M_AXIS_0_TUSER;
assign M_AXIS_0_m_axis_tuser[3:0]  = M_AXIS_0_TUSER_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( DFN1_0_Q ),
        .B ( B_IN_POST_INV0_0 ),
        // Outputs
        .Y ( AND2_0_Y_0 ) 
        );

//--------axi4_mem_model
axi4_mem_model #( 
        .AXI_ADDR_WIDTH ( 32 ),
        .AXI_DATA_WIDTH ( 64 ),
        .MEM_DEPTH      ( 262144 ) )
axi4_mem_model_0(
        // Inputs
        .aclk          ( ddr_clk_i ),
        .aresetn       ( rstn_i ),
        .s_axi_awaddr  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR ),
        .s_axi_awlen   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN ),
        .s_axi_awsize  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE ),
        .s_axi_awburst ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST ),
        .s_axi_awvalid ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID ),
        .s_axi_wdata   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA ),
        .s_axi_wstrb   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB ),
        .s_axi_wlast   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST ),
        .s_axi_wvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID ),
        .s_axi_bready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY ),
        .s_axi_araddr  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR ),
        .s_axi_arlen   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN ),
        .s_axi_arsize  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE ),
        .s_axi_arburst ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST ),
        .s_axi_arvalid ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID ),
        .s_axi_rready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY ),
        // Outputs
        .s_axi_awready ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY ),
        .s_axi_wready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY ),
        .s_axi_bresp   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .s_axi_bvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID ),
        .s_axi_arready ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY ),
        .s_axi_rdata   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA ),
        .s_axi_rresp   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP ),
        .s_axi_rlast   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST ),
        .s_axi_rvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID ) 
        );

//--------axis_bayer_demosaic_final
axis_bayer_demosaic_final #( 
        .BAYER_PATTERN ( 1 ),
        .DATA_WIDTH    ( 8 ),
        .MAX_IMG_WIDTH ( 2048 ) )
axis_bayer_demosaic_final_0(
        // Inputs
        .clk           ( pixel_clk ),
        .resetn        ( rstn_i ),
        .cfg_img_width ( cfg_img_width_const_net_0 ),
        .s_axis_tdata  ( DDR_Read_0_AXIS_M_TDATA ),
        .s_axis_tvalid ( DDR_Read_0_AXIS_M_TVALID ),
        .s_axis_tlast  ( DDR_Read_0_AXIS_M_TLAST ),
        .s_axis_tuser  ( DDR_Read_0_AXIS_M_TUSER ),
        .m_axis_tready ( M_AXIS_0_m_axis_tready ),
        // Outputs
        .s_axis_tready ( DDR_Read_0_AXIS_M_TREADY ),
        .m_axis_tdata  ( M_AXIS_0_TDATA ),
        .m_axis_tvalid ( M_AXIS_0_TVALID ),
        .m_axis_tlast  ( M_AXIS_0_TLAST ),
        .m_axis_tuser  ( M_AXIS_0_TUSER ) 
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
        .bid              ( bid_const_net_0 ), // tied to 4'h0 from definition
        .bresp            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .rid              ( rid_const_net_0 ), // tied to 4'h0 from definition
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
        .pixel_clk_i        ( pixel_clk ),
        .ddr_clk_i          ( ddr_clk_i ),
        .frame_start_i      ( AND2_0_Y_0 ),
        .RVALID_I           ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0 ),
        .ARREADY_I          ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0 ),
        .BUSER_I            ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0 ),
        .TREADY_I           ( DDR_Read_0_AXIS_M_TREADY ),
        .line_gap_i         ( line_gap_i_const_net_0 ),
        .horz_resl_i        ( horz_resl_i_const_net_0 ),
        .vert_resl_i        ( vert_resl_i_const_net_0 ),
        .frame_start_addr_i ( frame_start_addr_i_const_net_0 ),
        .h_offset_i         ( h_offset_i_const_net_0 ),
        .v_offset_i         ( v_offset_i_const_net_0 ),
        .RDATA_I            ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_0 ),
        // Outputs
        .ARVALID_O          ( DDR_Read_0_ARVALID_O ),
        .read_req_o         (  ),
        .TVALID_O           ( DDR_Read_0_AXIS_M_TVALID ),
        .TLAST_O            ( DDR_Read_0_AXIS_M_TLAST ),
        .ARADDR_O           ( DDR_Read_0_ARADDR_O ),
        .ARSIZE_O           ( DDR_Read_0_ARSIZE_O ),
        .read_start_addr_o  (  ),
        .burst_size_o       (  ),
        .TDATA_O            ( DDR_Read_0_AXIS_M_TDATA ),
        .TSTRB_O            ( DDR_Read_0_AXIS_M_TSTRB ),
        .TKEEP_O            ( DDR_Read_0_AXIS_M_TKEEP ),
        .TUSER_O            ( DDR_Read_0_AXIS_M_TUSER ) 
        );

//--------DFN1
DFN1 DFN1_0(
        // Inputs
        .D   ( Display_Controller_C0_0_V_ACTIVE_O ),
        .CLK ( pixel_clk ),
        // Outputs
        .Q   ( DFN1_0_Q ) 
        );

//--------DFN1
DFN1 DFN1_0_0(
        // Inputs
        .D   ( DFN1_0_Q ),
        .CLK ( pixel_clk ),
        // Outputs
        .Q   ( DFN1_0_0_Q ) 
        );

//--------Display_Controller_C0
Display_Controller_C0 Display_Controller_C0_0(
        // Inputs
        .RESETN_I       ( rstn_i ),
        .SYS_CLK_I      ( video_clk ),
        .ENABLE_I       ( rstn_i ),
        // Outputs
        .FRAME_END_O    (  ),
        .V_SYNC_O       (  ),
        .V_ACTIVE_O     ( Display_Controller_C0_0_V_ACTIVE_O ),
        .H_SYNC_O       (  ),
        .DATA_TRIGGER_O (  ),
        .H_RES_O        (  ),
        .V_RES_O        (  ) 
        );

//--------streamScaler
streamScaler #( 
        .BUFFER_SIZE        ( 4 ),
        .CHANNELS           ( 3 ),
        .DATA_WIDTH         ( 8 ),
        .DISCARD_CNT_WIDTH  ( 8 ),
        .FRACTION_BITS      ( 8 ),
        .INPUT_X_RES_WIDTH  ( 16 ),
        .INPUT_Y_RES_WIDTH  ( 16 ),
        .OUTPUT_X_RES_WIDTH ( 16 ),
        .OUTPUT_Y_RES_WIDTH ( 16 ),
        .SCALE_FRAC_BITS    ( 14 ),
        .SCALE_INT_BITS     ( 4 ) )
streamScaler_0(
        // Inputs
        .clk             ( GND_net ),
        .rst             ( GND_net ),
        .dInValid        ( GND_net ),
        .start           ( GND_net ),
        .nextDout        ( VCC_net ),
        .nearestNeighbor ( GND_net ),
        .dIn             ( dIn_const_net_0 ),
        .inputDiscardCnt ( inputDiscardCnt_const_net_0 ),
        .inputXRes       ( inputXRes_const_net_0 ),
        .inputYRes       ( inputYRes_const_net_0 ),
        .outputXRes      ( outputXRes_const_net_0 ),
        .outputYRes      ( outputYRes_const_net_0 ),
        .xScale          ( xScale_const_net_0 ),
        .yScale          ( yScale_const_net_0 ),
        .leftOffset      ( leftOffset_const_net_0 ),
        .topFracOffset   ( topFracOffset_const_net_0 ),
        // Outputs
        .nextDin         (  ),
        .dOutValid       (  ),
        .dOut            (  ) 
        );


endmodule
