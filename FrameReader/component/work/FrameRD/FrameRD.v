//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Feb 24 02:47:42 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FrameRD
module FrameRD(
    // Inputs
    ddr_clk_i,
    pixel_clk,
    rstn_i,
    video_clk
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  ddr_clk_i;
input  pixel_clk;
input  rstn_i;
input  video_clk;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [23:0] axis_bayer_demosaic_final_0_0_M_AXIS_TDATA;
wire          axis_bayer_demosaic_final_0_0_M_AXIS_TLAST;
wire          axis_bayer_demosaic_final_0_0_M_AXIS_TREADY;
wire          axis_bayer_demosaic_final_0_0_M_AXIS_TVALID;
wire   [23:0] axis_bayer_demosaic_final_0_M_AXIS_TDATA;
wire          axis_bayer_demosaic_final_0_M_AXIS_TLAST;
wire          axis_bayer_demosaic_final_0_M_AXIS_TREADY;
wire          axis_bayer_demosaic_final_0_M_AXIS_TVALID;
wire          DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_1;
wire          DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0;
wire          DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r1;
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
wire   [63:0] DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_1;
wire          DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0;
wire          DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_1;
wire          ddr_clk_i;
wire   [31:0] DDR_Read_0_0_ARADDR_O;
wire   [7:0]  DDR_Read_0_0_ARSIZE_O;
wire          DDR_Read_0_0_ARVALID_O;
wire   [7:0]  DDR_Read_0_0_AXIS_M_TDATA;
wire   [0:0]  DDR_Read_0_0_AXIS_M_TKEEP;
wire          DDR_Read_0_0_AXIS_M_TLAST;
wire          DDR_Read_0_0_AXIS_M_TREADY;
wire   [0:0]  DDR_Read_0_0_AXIS_M_TSTRB;
wire   [3:0]  DDR_Read_0_0_AXIS_M_TUSER;
wire          DDR_Read_0_0_AXIS_M_TVALID;
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
wire   [0:0]  Display_Controller_C0_0_DATA_TRIGGER_O;
wire          Display_Controller_C0_0_FRAME_END_O;
wire   [10:0] Display_Controller_C0_0_H_RES_O10to0;
wire   [0:0]  Display_Controller_C0_0_H_SYNC_O;
wire          Display_Controller_C0_0_V_ACTIVE_O;
wire   [10:0] Display_Controller_C0_0_V_RES_O10to0;
wire          Display_Controller_C0_0_V_SYNC_O;
wire          pixel_clk;
wire          rstn_i;
wire          TimingController_0_oDdrFrameStart;
wire          video_clk;
wire   [23:0] VideoCropper_0_M_AXIS_TDATA;
wire          VideoCropper_0_M_AXIS_TLAST;
wire          VideoCropper_0_M_AXIS_TREADY;
wire          VideoCropper_0_M_AXIS_TUSER;
wire          VideoCropper_0_M_AXIS_TVALID;
wire   [23:0] VideoMixerV20_0_M_AXIS_TDATA;
wire          VideoMixerV20_0_M_AXIS_TLAST;
wire          VideoMixerV20_0_M_AXIS_TREADY;
wire          VideoMixerV20_0_M_AXIS_TUSER;
wire          VideoMixerV20_0_M_AXIS_TVALID;
wire   [15:0] H_RES_O_net_0;
wire   [15:0] V_RES_O_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [11:0] cfg_img_width_const_net_0;
wire   [11:0] cfg_img_width_const_net_1;
wire          VCC_net;
wire   [15:0] line_gap_i_const_net_0;
wire   [15:0] horz_resl_i_const_net_0;
wire   [15:0] vert_resl_i_const_net_0;
wire   [7:0]  frame_start_addr_i_const_net_0;
wire   [11:0] h_offset_i_const_net_0;
wire   [11:0] v_offset_i_const_net_0;
wire   [15:0] line_gap_i_const_net_1;
wire   [15:0] horz_resl_i_const_net_1;
wire   [15:0] vert_resl_i_const_net_1;
wire   [7:0]  frame_start_addr_i_const_net_1;
wire   [11:0] h_offset_i_const_net_1;
wire   [11:0] v_offset_i_const_net_1;
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
wire   [10:0] iX1a_const_net_0;
wire   [10:0] iY1a_const_net_0;
wire   [10:0] iX1b_const_net_0;
wire   [10:0] iY1b_const_net_0;
wire   [1:0]  iDisplayLayer_const_net_0;
wire   [7:0]  iBackRed_const_net_0;
wire   [7:0]  iBackGreen_const_net_0;
wire   [7:0]  iBackBlue_const_net_0;
wire   [10:0] iPanX1_const_net_0;
wire   [10:0] iPanY1_const_net_0;
wire   [10:0] iHRES1_const_net_0;
wire   [10:0] iVRES1_const_net_0;
wire   [10:0] iPanX2_const_net_0;
wire   [10:0] iPanY2_const_net_0;
wire   [10:0] iHRES2_const_net_0;
wire   [10:0] iVRES2_const_net_0;
wire   [3:0]  bid_const_net_0;
wire   [3:0]  rid_const_net_0;
wire   [31:0] AWADDR_I_0_const_net_0;
wire   [7:0]  AWSIZE_I_0_const_net_0;
wire   [63:0] WDATA_I_0_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [3:0]  axis_bayer_demosaic_final_0_0_M_AXIS_TUSER;
wire          axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0;
wire   [0:0]  axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0_0to0;
wire   [3:0]  axis_bayer_demosaic_final_0_M_AXIS_TUSER;
wire          axis_bayer_demosaic_final_0_M_AXIS_TUSER_0;
wire   [0:0]  axis_bayer_demosaic_final_0_M_AXIS_TUSER_0_0to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign cfg_img_width_const_net_0      = 12'h300;
assign cfg_img_width_const_net_1      = 12'h150;
assign VCC_net                        = 1'b1;
assign line_gap_i_const_net_0         = 16'h1000;
assign horz_resl_i_const_net_0        = 16'h0300;
assign vert_resl_i_const_net_0        = 16'h0200;
assign frame_start_addr_i_const_net_0 = 8'h00;
assign h_offset_i_const_net_0         = 12'h000;
assign v_offset_i_const_net_0         = 12'h000;
assign line_gap_i_const_net_1         = 16'h1000;
assign horz_resl_i_const_net_1        = 16'h0150;
assign vert_resl_i_const_net_1        = 16'h0100;
assign frame_start_addr_i_const_net_1 = 8'h00;
assign h_offset_i_const_net_1         = 12'h050;
assign v_offset_i_const_net_1         = 12'h050;
assign GND_net                        = 1'b0;
assign dIn_const_net_0                = 24'h000000;
assign inputDiscardCnt_const_net_0    = 8'h00;
assign inputXRes_const_net_0          = 16'h0190;
assign inputYRes_const_net_0          = 16'h012C;
assign outputXRes_const_net_0         = 16'h0780;
assign outputYRes_const_net_0         = 16'h0438;
assign xScale_const_net_0             = 18'h00D4D;
assign yScale_const_net_0             = 18'h011BB;
assign leftOffset_const_net_0         = 30'h00000000;
assign topFracOffset_const_net_0      = 14'h0000;
assign iX1a_const_net_0               = 11'h096;
assign iY1a_const_net_0               = 11'h055;
assign iX1b_const_net_0               = 11'h257;
assign iY1b_const_net_0               = 11'h1F4;
assign iDisplayLayer_const_net_0      = 2'h1;
assign iBackRed_const_net_0           = 8'h00;
assign iBackGreen_const_net_0         = 8'h00;
assign iBackBlue_const_net_0          = 8'h00;
assign iPanX1_const_net_0             = 11'h000;
assign iPanY1_const_net_0             = 11'h000;
assign iHRES1_const_net_0             = 11'h1C2;
assign iVRES1_const_net_0             = 11'h1A0;
assign iPanX2_const_net_0             = 11'h000;
assign iPanY2_const_net_0             = 11'h000;
assign iHRES2_const_net_0             = 11'h150;
assign iVRES2_const_net_0             = 11'h100;
assign bid_const_net_0                = 4'h0;
assign rid_const_net_0                = 4'h0;
assign AWADDR_I_0_const_net_0         = 32'h00000000;
assign AWSIZE_I_0_const_net_0         = 8'h00;
assign WDATA_I_0_const_net_0          = 64'h0000000000000000;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign Display_Controller_C0_0_H_RES_O10to0 = H_RES_O_net_0[10:0];
assign Display_Controller_C0_0_V_RES_O10to0 = V_RES_O_net_0[10:0];
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0 = { axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0_0to0 };
assign axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0_0to0 = axis_bayer_demosaic_final_0_0_M_AXIS_TUSER[0:0];

assign axis_bayer_demosaic_final_0_M_AXIS_TUSER_0 = { axis_bayer_demosaic_final_0_M_AXIS_TUSER_0_0to0 };
assign axis_bayer_demosaic_final_0_M_AXIS_TUSER_0_0to0 = axis_bayer_demosaic_final_0_M_AXIS_TUSER[0:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------axi4_mem_model
axi4_mem_model #( 
        .AXI_ADDR_WIDTH ( 32 ),
        .AXI_DATA_WIDTH ( 64 ),
        .MEM_DEPTH      ( 262144 ) )
axi4_mem_model_0(
        // Inputs
        .aclk          ( ddr_clk_i ),
        .aresetn       ( rstn_i ),
        .s_axi_awvalid ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID ),
        .s_axi_wlast   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST ),
        .s_axi_wvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID ),
        .s_axi_bready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY ),
        .s_axi_arvalid ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID ),
        .s_axi_rready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY ),
        .s_axi_awaddr  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR ),
        .s_axi_awlen   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN ),
        .s_axi_awsize  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE ),
        .s_axi_awburst ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST ),
        .s_axi_wdata   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA ),
        .s_axi_wstrb   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB ),
        .s_axi_araddr  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR ),
        .s_axi_arlen   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN ),
        .s_axi_arsize  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE ),
        .s_axi_arburst ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST ),
        // Outputs
        .s_axi_awready ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY ),
        .s_axi_wready  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY ),
        .s_axi_bvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID ),
        .s_axi_arready ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY ),
        .s_axi_rlast   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST ),
        .s_axi_rvalid  ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID ),
        .s_axi_bresp   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .s_axi_rdata   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA ),
        .s_axi_rresp   ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP ) 
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
        .s_axis_tvalid ( DDR_Read_0_AXIS_M_TVALID ),
        .s_axis_tlast  ( DDR_Read_0_AXIS_M_TLAST ),
        .m_axis_tready ( axis_bayer_demosaic_final_0_M_AXIS_TREADY ),
        .cfg_img_width ( cfg_img_width_const_net_0 ),
        .s_axis_tdata  ( DDR_Read_0_AXIS_M_TDATA ),
        .s_axis_tuser  ( DDR_Read_0_AXIS_M_TUSER ),
        // Outputs
        .s_axis_tready ( DDR_Read_0_AXIS_M_TREADY ),
        .m_axis_tvalid ( axis_bayer_demosaic_final_0_M_AXIS_TVALID ),
        .m_axis_tlast  ( axis_bayer_demosaic_final_0_M_AXIS_TLAST ),
        .m_axis_tdata  ( axis_bayer_demosaic_final_0_M_AXIS_TDATA ),
        .m_axis_tuser  ( axis_bayer_demosaic_final_0_M_AXIS_TUSER ) 
        );

//--------axis_bayer_demosaic_final
axis_bayer_demosaic_final #( 
        .BAYER_PATTERN ( 1 ),
        .DATA_WIDTH    ( 8 ),
        .MAX_IMG_WIDTH ( 2048 ) )
axis_bayer_demosaic_final_0_0(
        // Inputs
        .clk           ( pixel_clk ),
        .resetn        ( rstn_i ),
        .cfg_img_width ( cfg_img_width_const_net_1 ),
        .s_axis_tdata  ( DDR_Read_0_0_AXIS_M_TDATA ),
        .s_axis_tvalid ( DDR_Read_0_0_AXIS_M_TVALID ),
        .s_axis_tlast  ( DDR_Read_0_0_AXIS_M_TLAST ),
        .s_axis_tuser  ( DDR_Read_0_0_AXIS_M_TUSER ),
        .m_axis_tready ( axis_bayer_demosaic_final_0_0_M_AXIS_TREADY ),
        // Outputs
        .s_axis_tready ( DDR_Read_0_0_AXIS_M_TREADY ),
        .m_axis_tdata  ( axis_bayer_demosaic_final_0_0_M_AXIS_TDATA ),
        .m_axis_tvalid ( axis_bayer_demosaic_final_0_0_M_AXIS_TVALID ),
        .m_axis_tlast  ( axis_bayer_demosaic_final_0_0_M_AXIS_TLAST ),
        .m_axis_tuser  ( axis_bayer_demosaic_final_0_0_M_AXIS_TUSER ) 
        );

//--------DDR_AXI4_ARBITER_PF_C0
DDR_AXI4_ARBITER_PF_C0 DDR_AXI4_ARBITER_PF_C0_0(
        // Inputs
        .reset_i          ( rstn_i ),
        .sys_clk_i        ( ddr_clk_i ),
        .ddr_ctrl_ready_i ( VCC_net ),
        .awready          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWREADY ),
        .wready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WREADY ),
        .bid              ( bid_const_net_0 ), // tied to 4'h0 from definition
        .bresp            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BRESP ),
        .bvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BVALID ),
        .arready          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARREADY ),
        .rid              ( rid_const_net_0 ), // tied to 4'h0 from definition
        .rdata            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RDATA ),
        .rresp            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RRESP ),
        .rlast            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RLAST ),
        .rvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RVALID ),
        .AWADDR_I_0       ( AWADDR_I_0_const_net_0 ), // tied to 32'h00000000 from definition
        .AWSIZE_I_0       ( AWSIZE_I_0_const_net_0 ), // tied to 8'h00 from definition
        .AWVALID_I_0      ( GND_net ), // tied to 1'b0 from definition
        .WDATA_I_0        ( WDATA_I_0_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_0       ( GND_net ), // tied to 1'b0 from definition
        .ARADDR_I_0       ( DDR_Read_0_ARADDR_O ),
        .ARSIZE_I_0       ( DDR_Read_0_ARSIZE_O ),
        .ARVALID_I_0      ( DDR_Read_0_ARVALID_O ),
        .ARADDR_I_1       ( DDR_Read_0_0_ARADDR_O ),
        .ARSIZE_I_1       ( DDR_Read_0_0_ARSIZE_O ),
        .ARVALID_I_1      ( DDR_Read_0_0_ARVALID_O ),
        // Outputs
        .awid             ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWID ),
        .awaddr           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWADDR ),
        .awlen            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLEN ),
        .awsize           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWSIZE ),
        .awburst          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWBURST ),
        .awlock           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWLOCK ),
        .awcache          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWCACHE ),
        .awprot           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWPROT ),
        .awvalid          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_AWVALID ),
        .wdata            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WDATA ),
        .wstrb            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WSTRB ),
        .wlast            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WLAST ),
        .wvalid           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_WVALID ),
        .bready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_BREADY ),
        .arid             ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARID ),
        .araddr           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARADDR ),
        .arlen            ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLEN ),
        .arsize           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARSIZE ),
        .arburst          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARBURST ),
        .arlock           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARLOCK ),
        .arcache          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARCACHE ),
        .arprot           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARPROT ),
        .arvalid          ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_ARVALID ),
        .rready           ( DDR_AXI4_ARBITER_PF_C0_0_MIRRORED_SLAVE_AXI4_RREADY ),
        .AWREADY_O_0      (  ),
        .BUSER_O_0        (  ),
        .ARREADY_O_0      ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_0 ),
        .RDATA_O_0        ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_0 ),
        .RLAST_O_0        (  ),
        .RVALID_O_0       ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_0 ),
        .BUSER_O_r0       ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r0 ),
        .ARREADY_O_1      ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_1 ),
        .RDATA_O_1        ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_1 ),
        .RLAST_O_1        (  ),
        .RVALID_O_1       ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_1 ),
        .BUSER_O_r1       ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r1 ) 
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
        .frame_start_i      ( TimingController_0_oDdrFrameStart ),
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
DDR_Read_0_0(
        // Inputs
        .reset_i            ( rstn_i ),
        .pixel_clk_i        ( pixel_clk ),
        .ddr_clk_i          ( ddr_clk_i ),
        .line_gap_i         ( line_gap_i_const_net_1 ),
        .horz_resl_i        ( horz_resl_i_const_net_1 ),
        .vert_resl_i        ( vert_resl_i_const_net_1 ),
        .frame_start_i      ( TimingController_0_oDdrFrameStart ),
        .frame_start_addr_i ( frame_start_addr_i_const_net_1 ),
        .h_offset_i         ( h_offset_i_const_net_1 ),
        .v_offset_i         ( v_offset_i_const_net_1 ),
        .RDATA_I            ( DDR_AXI4_ARBITER_PF_C0_0_RDATA_O_1 ),
        .RVALID_I           ( DDR_AXI4_ARBITER_PF_C0_0_RVALID_O_1 ),
        .ARREADY_I          ( DDR_AXI4_ARBITER_PF_C0_0_ARREADY_O_1 ),
        .BUSER_I            ( DDR_AXI4_ARBITER_PF_C0_0_BUSER_O_r1 ),
        .TREADY_I           ( DDR_Read_0_0_AXIS_M_TREADY ),
        // Outputs
        .ARADDR_O           ( DDR_Read_0_0_ARADDR_O ),
        .ARVALID_O          ( DDR_Read_0_0_ARVALID_O ),
        .ARSIZE_O           ( DDR_Read_0_0_ARSIZE_O ),
        .read_start_addr_o  (  ),
        .read_req_o         (  ),
        .burst_size_o       (  ),
        .TDATA_O            ( DDR_Read_0_0_AXIS_M_TDATA ),
        .TSTRB_O            ( DDR_Read_0_0_AXIS_M_TSTRB ),
        .TKEEP_O            ( DDR_Read_0_0_AXIS_M_TKEEP ),
        .TVALID_O           ( DDR_Read_0_0_AXIS_M_TVALID ),
        .TLAST_O            ( DDR_Read_0_0_AXIS_M_TLAST ),
        .TUSER_O            ( DDR_Read_0_0_AXIS_M_TUSER ) 
        );

//--------Display_Controller_C0
Display_Controller_C0 Display_Controller_C0_0(
        // Inputs
        .RESETN_I       ( rstn_i ),
        .SYS_CLK_I      ( video_clk ),
        .ENABLE_I       ( rstn_i ),
        // Outputs
        .FRAME_END_O    ( Display_Controller_C0_0_FRAME_END_O ),
        .V_SYNC_O       ( Display_Controller_C0_0_V_SYNC_O ),
        .V_ACTIVE_O     ( Display_Controller_C0_0_V_ACTIVE_O ),
        .H_SYNC_O       ( Display_Controller_C0_0_H_SYNC_O ),
        .DATA_TRIGGER_O ( Display_Controller_C0_0_DATA_TRIGGER_O ),
        .H_RES_O        ( H_RES_O_net_0 ),
        .V_RES_O        ( V_RES_O_net_0 ) 
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
        .rst             ( VCC_net ),
        .dInValid        ( GND_net ),
        .start           ( GND_net ),
        .nextDout        ( GND_net ),
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

//--------TimingController
TimingController #( 
        .pColorWidth ( 8 ),
        .pNChannels  ( 3 ),
        .pPPC        ( 1 ) )
TimingController_0(
        // Inputs
        .iPixelClk      ( pixel_clk ),
        .iVideoClk      ( video_clk ),
        .rst_n          ( rstn_i ),
        .s_axis_tdata   ( VideoMixerV20_0_M_AXIS_TDATA ),
        .s_axis_tvalid  ( VideoMixerV20_0_M_AXIS_TVALID ),
        .s_axis_tlast   ( VideoMixerV20_0_M_AXIS_TLAST ),
        .s_axis_tuser   ( VideoMixerV20_0_M_AXIS_TUSER ),
        .iHSync         ( Display_Controller_C0_0_H_SYNC_O ),
        .iVSync         ( Display_Controller_C0_0_V_SYNC_O ),
        .iDataTrigger   ( Display_Controller_C0_0_DATA_TRIGGER_O ),
        .iVideoActive   ( Display_Controller_C0_0_V_ACTIVE_O ),
        .iEOF           ( Display_Controller_C0_0_FRAME_END_O ),
        // Outputs
        .s_axis_tready  ( VideoMixerV20_0_M_AXIS_TREADY ),
        .oVideo         (  ),
        .oVsync         (  ),
        .oHSYnc         (  ),
        .oDV            (  ),
        .oDdrFrameStart ( TimingController_0_oDdrFrameStart ) 
        );

//--------VideoCropper
VideoCropper #( 
        .pColorWidth ( 8 ),
        .pMaxHRes    ( 1920 ),
        .pMaxVRes    ( 1080 ),
        .pNChannels  ( 3 ),
        .pPPC        ( 1 ) )
VideoCropper_0(
        // Inputs
        .iPixClk  ( pixel_clk ),
        .iPixRstn ( rstn_i ),
        .iX1a     ( iX1a_const_net_0 ),
        .iY1a     ( iY1a_const_net_0 ),
        .iX1b     ( iX1b_const_net_0 ),
        .iY1b     ( iY1b_const_net_0 ),
        .iTDATA   ( axis_bayer_demosaic_final_0_M_AXIS_TDATA ),
        .iTVALID  ( axis_bayer_demosaic_final_0_M_AXIS_TVALID ),
        .iTLAST   ( axis_bayer_demosaic_final_0_M_AXIS_TLAST ),
        .iTUSER   ( axis_bayer_demosaic_final_0_M_AXIS_TUSER_0 ),
        .iTREADY  ( VideoCropper_0_M_AXIS_TREADY ),
        // Outputs
        .oTREADY  ( axis_bayer_demosaic_final_0_M_AXIS_TREADY ),
        .oTDATA   ( VideoCropper_0_M_AXIS_TDATA ),
        .oTVALID  ( VideoCropper_0_M_AXIS_TVALID ),
        .oTLAST   ( VideoCropper_0_M_AXIS_TLAST ),
        .oTUSER   ( VideoCropper_0_M_AXIS_TUSER ) 
        );

//--------VideoMixerV20
VideoMixerV20 #( 
        .pActiveLayers ( 2 ),
        .pColorWidth   ( 8 ),
        .pMaxLayers    ( 2 ),
        .pMonitorHres  ( 1920 ),
        .pMonitorVres  ( 1080 ),
        .pNChannels    ( 3 ),
        .pPPC          ( 1 ) )
VideoMixerV20_0(
        // Inputs
        .iPixClk       ( pixel_clk ),
        .iPixRstn      ( rstn_i ),
        .iHRESBack     ( Display_Controller_C0_0_H_RES_O10to0 ),
        .iVRESBack     ( Display_Controller_C0_0_V_RES_O10to0 ),
        .iSWResetN     ( VCC_net ),
        .iStart        ( VCC_net ),
        .iStop         ( GND_net ),
        .iDisplayLayer ( iDisplayLayer_const_net_0 ),
        .iBackRed      ( iBackRed_const_net_0 ),
        .iBackGreen    ( iBackGreen_const_net_0 ),
        .iBackBlue     ( iBackBlue_const_net_0 ),
        .iPanX1        ( iPanX1_const_net_0 ),
        .iPanY1        ( iPanY1_const_net_0 ),
        .iHRES1        ( iHRES1_const_net_0 ),
        .iVRES1        ( iVRES1_const_net_0 ),
        .iLayer1En     ( VCC_net ),
        .iTDATA1       ( VideoCropper_0_M_AXIS_TDATA ),
        .iTVALID1      ( VideoCropper_0_M_AXIS_TVALID ),
        .iTLAST1       ( VideoCropper_0_M_AXIS_TLAST ),
        .iTUSER1       ( VideoCropper_0_M_AXIS_TUSER ),
        .iPanX2        ( iPanX2_const_net_0 ),
        .iPanY2        ( iPanY2_const_net_0 ),
        .iHRES2        ( iHRES2_const_net_0 ),
        .iVRES2        ( iVRES2_const_net_0 ),
        .iLayer2En     ( VCC_net ),
        .iTDATA2       ( axis_bayer_demosaic_final_0_0_M_AXIS_TDATA ),
        .iTVALID2      ( axis_bayer_demosaic_final_0_0_M_AXIS_TVALID ),
        .iTLAST2       ( axis_bayer_demosaic_final_0_0_M_AXIS_TLAST ),
        .iTUSER2       ( axis_bayer_demosaic_final_0_0_M_AXIS_TUSER_0 ),
        .iTREADY       ( VideoMixerV20_0_M_AXIS_TREADY ),
        // Outputs
        .oInt          (  ),
        .oTREADY1      ( VideoCropper_0_M_AXIS_TREADY ),
        .oTREADY2      ( axis_bayer_demosaic_final_0_0_M_AXIS_TREADY ),
        .oTDATA        ( VideoMixerV20_0_M_AXIS_TDATA ),
        .oTVALID       ( VideoMixerV20_0_M_AXIS_TVALID ),
        .oTLAST        ( VideoMixerV20_0_M_AXIS_TLAST ),
        .oTUSER        ( VideoMixerV20_0_M_AXIS_TUSER ) 
        );


endmodule
