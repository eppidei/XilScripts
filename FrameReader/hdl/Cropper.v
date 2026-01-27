///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Cropper.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCSG325>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module Cropper #(
parameter pAXI_DATA_WIDTH = 24
//parameter pHRES = 1920,
//parameter pVRES = 1080
)
(
input iClk,
input iRstn,

input [15:0] iCROP_X1,
input [15:0] iCROP_X2,
input [15:0] iCROP_Y1,
input [15:0] iCROP_Y2,

//S_AXIS
input [pAXI_DATA_WIDTH-1:0] s_tdata,
input                      s_tdata_valid,
input                      s_tlast,
input [3:0]                s_user,
output                     s_ready,
//M_AXIS
output [pAXI_DATA_WIDTH-1:0] m_tdata,
output                      m_tdata_valid,
output                      m_tlast,
output [3:0]                m_user,
input                       m_ready

);

reg [15:0]  rCOL_CNT;
reg [15:0]  rROW_CNT;
wire        ws_SOF;
wire        wValidCnt;

assign ws_SOF           = s_user[0];
assign wValidCnt        = (m_ready & s_tdata_valid) ? 1 : 0;
assign m_tdata_valid    = (rCNT>=iCROP_X1 && rCNT<=iCROP_X2 && rCNT>=iCROP_Y1 && rCNT>=iCROP_Y2 ) ? s_tdata_valid : 0;
assign m_user [0]       = (rCNT==iCROP_X1 && rCNT==iCROP_Y1)? 1: 0;
assign m_user [1]       = 0;
assign m_user [2]       = 0;
assign m_user [3]       = 0;
assign m_tlast          = (rCNT==iCROP_X2)? 1: 0;;

assign m_tdata = s_tdata;
assign s_ready = m_ready;

always@(posedge iClk) begin
    if (~iRstn) begin
        rCOL_CNT <= 0;
        rROW_CNT <= 0;
    end else begin
        if (wValidCnt==1) begin
            if (ws_SOF) begin 
                rCOL_CNT <= 0;
                rROW_CNT <= 0;
        else if (wValidCnt==1) rCNT <= rCNT+1;
    end
end

//<statements>

endmodule

