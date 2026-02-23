`timescale 1 ns/100 ps
// Version: 2025.1 2025.1.0.14


module TCTRL_FIFO_TCTRL_FIFO_0_LSRAM_top(
       W_DATA,
       R_DATA,
       W_ADDR,
       R_ADDR,
       W_EN,
       R_EN,
       W_CLK,
       R_CLK
    );
input  [23:0] W_DATA;
output [23:0] R_DATA;
input  [10:0] W_ADDR;
input  [10:0] R_ADDR;
input  W_EN;
input  R_EN;
input  W_CLK;
input  R_CLK;

    wire \ACCESS_BUSY[0][0] , \ACCESS_BUSY[0][1] , \ACCESS_BUSY[0][2] , 
        VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K20 #( .RAMINDEX("core%2048-2048%24-24%SPEED%0%1%TWO-PORT%ECC_EN-0")
         )  TCTRL_FIFO_TCTRL_FIFO_0_LSRAM_top_R0C1 (.A_DOUT({nc0, nc1, 
        nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, R_DATA[15], 
        R_DATA[14], R_DATA[13], R_DATA[12], R_DATA[11], R_DATA[10], 
        R_DATA[9], R_DATA[8]}), .B_DOUT({nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27, nc28, nc29, nc30, nc31}), .DB_DETECT(), .SB_CORRECT(), 
        .ACCESS_BUSY(\ACCESS_BUSY[0][1] ), .A_ADDR({R_ADDR[10], 
        R_ADDR[9], R_ADDR[8], R_ADDR[7], R_ADDR[6], R_ADDR[5], 
        R_ADDR[4], R_ADDR[3], R_ADDR[2], R_ADDR[1], R_ADDR[0], GND, 
        GND, GND}), .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(R_CLK), .A_DIN({
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND}), .A_REN(R_EN), .A_WEN({
        GND, GND}), .A_DOUT_EN(VCC), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .B_ADDR({W_ADDR[10], W_ADDR[9], W_ADDR[8], 
        W_ADDR[7], W_ADDR[6], W_ADDR[5], W_ADDR[4], W_ADDR[3], 
        W_ADDR[2], W_ADDR[1], W_ADDR[0], GND, GND, GND}), .B_BLK_EN({
        W_EN, VCC, VCC}), .B_CLK(W_CLK), .B_DIN({GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, W_DATA[15], W_DATA[14], 
        W_DATA[13], W_DATA[12], W_DATA[11], W_DATA[10], W_DATA[9], 
        W_DATA[8]}), .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(VCC), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(VCC), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(VCC), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("core%2048-2048%24-24%SPEED%0%2%TWO-PORT%ECC_EN-0")
         )  TCTRL_FIFO_TCTRL_FIFO_0_LSRAM_top_R0C2 (.A_DOUT({nc32, 
        nc33, nc34, nc35, nc36, nc37, nc38, nc39, nc40, nc41, nc42, 
        nc43, R_DATA[23], R_DATA[22], R_DATA[21], R_DATA[20], 
        R_DATA[19], R_DATA[18], R_DATA[17], R_DATA[16]}), .B_DOUT({
        nc44, nc45, nc46, nc47, nc48, nc49, nc50, nc51, nc52, nc53, 
        nc54, nc55, nc56, nc57, nc58, nc59, nc60, nc61, nc62, nc63}), 
        .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][2] ), 
        .A_ADDR({R_ADDR[10], R_ADDR[9], R_ADDR[8], R_ADDR[7], 
        R_ADDR[6], R_ADDR[5], R_ADDR[4], R_ADDR[3], R_ADDR[2], 
        R_ADDR[1], R_ADDR[0], GND, GND, GND}), .A_BLK_EN({VCC, VCC, 
        VCC}), .A_CLK(R_CLK), .A_DIN({GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND}), .A_REN(R_EN), .A_WEN({GND, GND}), .A_DOUT_EN(VCC), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .B_ADDR({W_ADDR[10], 
        W_ADDR[9], W_ADDR[8], W_ADDR[7], W_ADDR[6], W_ADDR[5], 
        W_ADDR[4], W_ADDR[3], W_ADDR[2], W_ADDR[1], W_ADDR[0], GND, 
        GND, GND}), .B_BLK_EN({W_EN, VCC, VCC}), .B_CLK(W_CLK), .B_DIN({
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        W_DATA[23], W_DATA[22], W_DATA[21], W_DATA[20], W_DATA[19], 
        W_DATA[18], W_DATA[17], W_DATA[16]}), .B_REN(VCC), .B_WEN({GND, 
        VCC}), .B_DOUT_EN(VCC), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), 
        .A_WMODE({GND, GND}), .A_BYPASS(VCC), .B_WIDTH({GND, VCC, VCC})
        , .B_WMODE({GND, GND}), .B_BYPASS(VCC), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("core%2048-2048%24-24%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  TCTRL_FIFO_TCTRL_FIFO_0_LSRAM_top_R0C0 (.A_DOUT({nc64, 
        nc65, nc66, nc67, nc68, nc69, nc70, nc71, nc72, nc73, nc74, 
        nc75, R_DATA[7], R_DATA[6], R_DATA[5], R_DATA[4], R_DATA[3], 
        R_DATA[2], R_DATA[1], R_DATA[0]}), .B_DOUT({nc76, nc77, nc78, 
        nc79, nc80, nc81, nc82, nc83, nc84, nc85, nc86, nc87, nc88, 
        nc89, nc90, nc91, nc92, nc93, nc94, nc95}), .DB_DETECT(), 
        .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][0] ), .A_ADDR({
        R_ADDR[10], R_ADDR[9], R_ADDR[8], R_ADDR[7], R_ADDR[6], 
        R_ADDR[5], R_ADDR[4], R_ADDR[3], R_ADDR[2], R_ADDR[1], 
        R_ADDR[0], GND, GND, GND}), .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(
        R_CLK), .A_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_REN(R_EN), .A_WEN({GND, GND}), .A_DOUT_EN(VCC), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .B_ADDR({W_ADDR[10], 
        W_ADDR[9], W_ADDR[8], W_ADDR[7], W_ADDR[6], W_ADDR[5], 
        W_ADDR[4], W_ADDR[3], W_ADDR[2], W_ADDR[1], W_ADDR[0], GND, 
        GND, GND}), .B_BLK_EN({W_EN, VCC, VCC}), .B_CLK(W_CLK), .B_DIN({
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        W_DATA[7], W_DATA[6], W_DATA[5], W_DATA[4], W_DATA[3], 
        W_DATA[2], W_DATA[1], W_DATA[0]}), .B_REN(VCC), .B_WEN({GND, 
        VCC}), .B_DOUT_EN(VCC), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), 
        .A_WMODE({GND, GND}), .A_BYPASS(VCC), .B_WIDTH({GND, VCC, VCC})
        , .B_WMODE({GND, GND}), .B_BYPASS(VCC), .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
