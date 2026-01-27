///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: RDYCTRL.v
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

module RDYCTRL( iCLK, oRdy, iRSTN );
input iCLK, iRSTN;
output oRdy;

reg [3:0] rCnt;


assign oRdy = (rCnt==7) ? 0 : 1;

always@(posedge iCLK) begin
    if (!iRSTN) begin 
        rCnt <= 0;
    end else begin
        rCnt <= rCnt+1;
    end
end

//<statements>

endmodule

