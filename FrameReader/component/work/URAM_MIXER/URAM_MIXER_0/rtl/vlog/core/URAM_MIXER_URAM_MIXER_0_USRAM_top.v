`timescale 1 ns/100 ps
// Version: 2025.1 2025.1.0.14


module URAM_MIXER_URAM_MIXER_0_USRAM_top(
       R_DATA,
       W_DATA,
       R_ADDR,
       W_ADDR,
       BLK_EN,
       R_ADDR_SRST_N,
       R_ADDR_EN,
       R_CLK,
       W_CLK,
       W_EN
    );
output [11:0] R_DATA;
input  [11:0] W_DATA;
input  [5:0] R_ADDR;
input  [5:0] W_ADDR;
input  BLK_EN;
input  R_ADDR_SRST_N;
input  R_ADDR_EN;
input  R_CLK;
input  W_CLK;
input  W_EN;

    wire \ACCESS_BUSY[0][0] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM64x12 #( .RAMINDEX("core%64%12%SPEED%0%0%MICRO_RAM") )  
        URAM_MIXER_URAM_MIXER_0_USRAM_top_R0C0 (.BLK_EN(BLK_EN), 
        .BUSY_FB(GND), .R_ADDR({R_ADDR[5], R_ADDR[4], R_ADDR[3], 
        R_ADDR[2], R_ADDR[1], R_ADDR[0]}), .R_ADDR_AD_N(VCC), 
        .R_ADDR_AL_N(VCC), .R_ADDR_BYPASS(GND), .R_ADDR_EN(R_ADDR_EN), 
        .R_ADDR_SD(GND), .R_ADDR_SL_N(R_ADDR_SRST_N), .R_CLK(R_CLK), 
        .R_DATA_AD_N(VCC), .R_DATA_AL_N(VCC), .R_DATA_BYPASS(VCC), 
        .R_DATA_EN(VCC), .R_DATA_SD(GND), .R_DATA_SL_N(VCC), .W_ADDR({
        W_ADDR[5], W_ADDR[4], W_ADDR[3], W_ADDR[2], W_ADDR[1], 
        W_ADDR[0]}), .W_CLK(W_CLK), .W_DATA({W_DATA[11], W_DATA[10], 
        W_DATA[9], W_DATA[8], W_DATA[7], W_DATA[6], W_DATA[5], 
        W_DATA[4], W_DATA[3], W_DATA[2], W_DATA[1], W_DATA[0]}), .W_EN(
        W_EN), .ACCESS_BUSY(\ACCESS_BUSY[0][0] ), .R_DATA({R_DATA[11], 
        R_DATA[10], R_DATA[9], R_DATA[8], R_DATA[7], R_DATA[6], 
        R_DATA[5], R_DATA[4], R_DATA[3], R_DATA[2], R_DATA[1], 
        R_DATA[0]}));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
