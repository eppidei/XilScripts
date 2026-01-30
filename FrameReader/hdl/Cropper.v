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
input                       m_ready,
output                      oStart

);

reg [15:0]  rCOL_CNT;
reg [15:0]  rROW_CNT;
wire        ws_SOF;
wire        wValidCnt;
wire        wStart;
reg        rStart;
wire        wAutoRst;

assign ws_SOF           = s_user[0];
assign wValidCnt        = (m_ready & s_tdata_valid) ? 1 : 0;
assign m_tdata_valid    = (rCOL_CNT>=iCROP_X1 && rCOL_CNT<=iCROP_X2 && rROW_CNT>=iCROP_Y1 && rROW_CNT<=iCROP_Y2 ) ? 1 : 0;
assign wStart           = (rCOL_CNT==(iCROP_X1-2) && rROW_CNT==iCROP_Y1)? 1: 0;
assign m_user [0]       = (rCOL_CNT==iCROP_X1 && rROW_CNT==iCROP_Y1)? 1: 0;
assign m_user [1]       = 0;
assign m_user [2]       = 0;
assign m_user [3]       = 0;
assign m_tlast          = (rCOL_CNT==iCROP_X2 && rROW_CNT>=iCROP_Y1 && rROW_CNT<=iCROP_Y2)? 1: 0;

assign m_tdata = s_tdata;
assign s_ready = m_ready;

assign wAutoRst = (rStart==1) ? 0 : wStart;
assign oStart   = rStart;

always@(posedge iClk) begin
    if (~iRstn) begin
        rCOL_CNT <= 0;
        rROW_CNT <= 0;
        rStart   <= 0;
    end else begin
        rStart   <= wAutoRst;
        if (wValidCnt==1) begin
            rCOL_CNT <= rCOL_CNT+1;
            if (ws_SOF) begin 
                rCOL_CNT <= 1;
                rROW_CNT <= 0;
            end  else  if (s_tlast) begin
                rCOL_CNT <= 0;
                rROW_CNT <= rROW_CNT+1;
            end
        end
    end
end

//<statements>

endmodule

