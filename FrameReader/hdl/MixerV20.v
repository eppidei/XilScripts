module VideoMixerV20 #(
    parameter pActivelayers       = 2, //less or equal than available ports
    parameter pColorWidth         = 8,
    parameter pPPC                = 1,
    parameter pMonitorHres        = 1920,
    parameter pMonitorVres        = 1080,
    parameter pNChannels          = 4,
)
(
    //Globals
    input                                   iPixClk     ,
    input                                   iPixRstn    ,

    input             [$clog2(pMonitorHres)-1:0]                iHRESBack   ,
    input             [$clog2(pMonitorVres)-1:0]                iVRESBack   ,

    //CTRL is assumed to be synchronous to Pix Clk
    input                                   iSWResetN   ,
    input                                   iStart      ,
    input                                   iStop       ,
    output                                  oInt        ,

    //Background Layer
    
    input             [pColorWidth-1:0]     iBackRed    ,
    input             [pColorWidth-1:0]     iBackGreen  ,
    input             [pColorWidth-1:0]     iBackBlue   ,

    //Layer 1

    // subwindows coordinates are referenced to an upper left anchor point
    // ASSUMPTION : we use only achor point , if length exceed we should be able to cut
    input             [$clog2(pMonitorHres)-1:0]                 iPanX1      ,
    input             [$clog2(pMonitorVres)-1:0]                 iPanY1      ,
    input             [$clog2(pMonitorHres)-1:0]                iHRES1      ,
    input            [$clog2(pMonitorVres)-1:0]               iVRES1      ,
    input                                   iLayer1On   ,
    
    input             [(pPPC)*(1+3)*pColorWidth-1:0] iTDATA1 ,
    input                                   iTVALID1    ,
    input                                   iTLAST1     ,
    input             [3:0]                 iTUSER1     ,
    output                                  oTREADY1    ,

    //Layer 2
    
    input              [$clog2(pMonitorHres)-1:0]                 iPanX2      ,
    input             [$clog2(pMonitorVres)-1:0]                 iPanY2      ,
    input              [$clog2(pMonitorHres)-1:0]                iHRES2      ,
    input             [$clog2(pMonitorVres)-1:0]                iVRES2      ,
    input                                   iLayer2On   ,
    
    input             [(pPPC)*(1+3)*pColorWidth-1:0] iTDATA2 ,
    input                                   iTVALID2    ,
    input                                   iTLAST2     ,
    input             [3:0]                 iTUSER2     ,
    output                                  oTREADY2    ,

    // Output
    
    output    [(pPPC)*(3)*pColorWidth-1:0]  oTDATA      ,
    output                                  oTVALID     ,
    output                                  oTLAST      ,
    output            [3:0]                 oTUSER      ,
    input                                   iTREADY     
);



function int check_data_synched (input int actual_index,input Ready2Display [1:pActivelayers],input FifoDataValid [1:pActivelayers] );
    
    // Initialize result with -1 (meaning not found)
    get_indices = '{default: -1}; 

    for (int i = 1; i <= pActivelayers; i++) begin
        if (i!=actual_index && Ready2Display[i]==1) begin
            if (!FifoDataValid[i]) begin
                return 0;
            end
        end
    end
    
    return 1;
endfunction


    localparam int lpMAXHRES      = 4096;
    localparam int lpMAXVRES      = 2160;
   // localparam int lpNChannels    = 4; //3 Colors + Alpha
    localparam int lpURAMDepth    = 64;
    localparam int lpURAMWidth    = 12;
    localparam int lpFifoWidth    = lpURAMWidth;
    localparam int lpFifoDepth    = lpURAMDepth;
    localparam int lpFifoPadNBit  = lpURAMWidth -( pColorWidth +1);
    localparam int lpNumStates    = 3;
    localparam stIDLE=0, stCOL_COUNT=1, st_ROW_INC=2;
    localparam int lpUSER_BITFIELD = 0; //in FIFO DATA PACKING
    localparam int lpLAST_BITFIELD = 1;
    
    reg    [(pPPC)*(3)*pColorWidth-1:0]  rTDATA      ;
    reg                                  rTVALID     ;
    reg                                  rTLAST      ;
    reg            [3:0]                 rTUSER      ;

    //PARAMETERS
    
    reg               [pColorWidth-1:0] rBackRed    ;
    reg               [pColorWidth-1:0] rBackGreen  ;
    reg               [pColorWidth-1:0] rBackBlue   ;
    reg                      [$clog2(lpMAXHRES)-1:0]           rPANX       [1:pActivelayers];
    reg                      [$clog2(lpMAXHRES)-1:0]           rHRES       [1:pActivelayers];
    reg                       [$clog2(lpMAXVRES)-1:0]          rPANY       [1:pActivelayers];
    reg                       [$clog2(lpMAXVRES)-1:0]          rVRES       [1:pActivelayers];



    //INTERNAL COUNTERS and UTIL signals
    
    reg               [$clog2(lpMAXHRES)-1:0] rHCountGlobal   ;
    reg               [$clog2(lpMAXVRES)-1:0] rVCountGlobal   ;
    wire                                    wSW_HW_RSTN ;
    reg                [$clog2(lpNumStates)-1:0] rSTATE ;
    
    //Stream/Channels declarations
    
    reg               [$clog2(lpMAXHRES)-1:0] rHCountLayer  [1:pActivelayers];
    reg               [$clog2(lpMAXVRES)-1:0] rVCountLayer   [1:pActivelayers];
    

    
    reg               [pColorWidth-1:0] rMixedCh1;
    reg               [pColorWidth-1:0] rMixedCh2;
    reg               [pColorWidth-1:0] rMixedCh3;
  //  reg               [pColorWidth-1:0] rMixedAlpha;

    wire              [pColorWidth-1:0] wDATA       [1:pActivelayers][1:lpNChannels];
    wire              [pColorWidth-1:0] wVALID      [1:pActivelayers];
    wire              [pColorWidth-1:0] wLAST       [1:pActivelayers];
    wire              [pColorWidth-1:0] wUSER       [1:pActivelayers];
    wire            [pColorWidth+2-1:0] wFIFODATA   [1:pActivelayers][1:lpNChannels];
    wire                                wFIFOVALID  [1:pActivelayers][1:lpNChannels];
    wire                                wFIFOREN    [1:pActivelayers][1:lpNChannels];
    wire                                wFIFOEMPTY  [1:pActivelayers][1:lpNChannels];
    wire                                wFIFOFULL   [1:pActivelayers][1:lpNChannels];

    wire                                wLayerDataValid [1:pActivelayers] ;
    wire                                wLayerREN  [1:pActivelayers]   ;
    wire                                wLayerSOF    [1:pActivelayers]   ;
    reg                                 rLayerRENTmp [1:pActivelayers] ;
    wire                                wALLLayersDataValid  ;
    wire                                wALLLayersSOF  ;
    wire                                wREADY4ALL  ;
    wire                                wLayerEnabled [1:pActivelayers] ;
    wire                                wLayerReadyToDisplay [1:pActivelayers] ; //means enabled and in the pan period
  //  wire                                wLayerReadyToDisplayOtherThanMe [1:pActivelayers] ;
    wire                                wAtLeastOneLayerDisplay ;
    wire                                wALLLayersDisabled ;

    assign            wSW_HW_RSTN       = iPixRstn & iSWResetN;

    // ASSIGN INPUT to INDEXED ARRAYS
    
    
    assign            wDATA[1][1]       = iTDATA1[1*pColorWidth-1:0*pColorWidth];
    assign            wDATA[1][2]       = iTDATA1[2*pColorWidth-1:1*pColorWidth];
    assign            wDATA[1][3]       = iTDATA1[3*pColorWidth-1:2*pColorWidth];
    assign            wDATA[1][4]       = iTDATA1[4*pColorWidth-1:3*pColorWidth];
    assign            wVALID[1]         = iTVALID1;
    assign            wLAST[1]          = iTLAST1;
    assign            wUSER[1]          = iTUSER1;
    assign            wLayerEnabled[1]       = iLayer1On;
    
    assign            wDATA[2][1]       = iTDATA2[1*pColorWidth-1:0*pColorWidth];
    assign            wDATA[2][2]       = iTDATA2[2*pColorWidth-1:1*pColorWidth];
    assign            wDATA[2][3]       = iTDATA2[3*pColorWidth-1:2*pColorWidth];
    assign            wDATA[2][4]       = iTDATA2[4*pColorWidth-1:3*pColorWidth];
    assign            wVALID[2]         = iTVALID2;
    assign            wLAST[2]          = iTLAST2;
    assign            wUSER[2]          = iTUSER2;
    assign            wLayerEnabled[2]       = iLayer2On;
    

        //Latching dynamic parameter at the EOF
    always@(posedge iPixClk)
    begin : ParamsLatch
        if (!wSW_HW_RSTN) begin
        
        end else if (sSTATE==stIDLE) begin
                rPANX[1]<=iPanX1;
                rPANY[1]<=iPanY1;
                rHRES[1]<=iHRES1;
                rYRES[1]<=iYRES1;
                rPANX[2]<=iPanX2;
                rPANY[2]<=iPanY2;
                rHRES[2]<=iHRES2;
                rYRES[2]<=iYRES2;
        end
    end

integer f;
always@(*) begin

assign wALLLayersDataValid           = 1;
assign wALLLayersSOF                 = 1;
assign wAtLeastOneLayerDisplay       = 0;
assign wALLLayersDisabled            = 1;

    for (f=1; f<=pActivelayers; f=f+1) begin 

    assign wALLLayersDataValid      = wALLLayersDataValid       &  wLayerDataValid[f];
    assign wALLLayersSOF            = wALLLayersSOF             &  wLayerSOF[f];
    assign wAtLeastOneLayerDisplay  = wAtLeastOneLayerDisplay   |  wLayerReadyToDisplay[f];
    assign wALLLayersDisabled       = wALLLayersDisabled        &~ wLayerEnabled[f];

    end
end

    
    
    assign oTREADY1         = iTREADY & wREADY[1];
    assign wmREADY[1]       = 1;
    
  //  assign rALLStreamsREN   = (rALLStreamsRENTmp==0) ? 0 : (wALLStreamsValid==0 && rALLStreamsRENTmp==1) ? 0 : 1; //disable read as soon as valid is de-asserted
    
    genvar i, k,z;
    generate
        for (k=1; k<=pActivelayers; k=k+1) begin : Gen_KLayer
        
            assign wLayerDataValid[k]               = wFIFOVALID[k][1]; //Channels use same valid
            assign wLayerSOF[k]                     = wFIFODATA[k][1][0];// we use first channel cos same layer tuser is packed in every channel 
            assign wLayerReadyToDisplay[k]       = (wLayerEnabled[k]==1 && (rHCountGlobal>=rPANX[k] && ) ? 1 : 0;
           
            
            for (i=1; i<=lpNChannels; i=i+1) begin : Gen_iChannel_kLayer
            
              //  assign wFIFOREN[k][i] = rALLStreamsREN;
              
                
                // MUST BE CONFIGURED AS FWFT
                URAM_MIXER iChannelFIFOStreamK (
                    // Inputs
                    .DATA       ({wDATA[k][i], wLAST[k], wUSER[k]}),
                    .RCLOCK     (iPixClk),
                    .RE         (wFIFOREN[k][i]),
                    .RRESET_N   (wSW_HW_RSTN),
                    .WCLOCK     (iPixClk),
                    .WE         (wVALID[k]),
                    .WRESET_N   (wSW_HW_RSTN),
                    // Outputs
                    .DVLD       (wFIFOVALID[k][i]),
                    .EMPTY      (wFIFOEMPTY[k][i]),
                    .FULL       (wFIFOFULL[k][i]),
                    .Q          (wFIFODATA[k][i])
                );
             end
        end
    endgenerate



    integer l;
    
    always@(posedge iPixClk)
    begin : MainIterator
        if (!wSW_HW_RSTN) begin
            rLayerRENTmp    <= '{default:0};
            rHCountLayer    <= '{default:0};
            rVCountLayer    <= '{default:0};
            rHCountGlobal   <= 0;
            rVCountGlobal   <= 0;
            rSTATE          <= stIDLE;
            rMixedCh1       <= 0;
            rTDATA          <=0;
            rTLAST          <=0;
            rTVALID         <=0;
            rTUSER          <=0;
        end else begin
            if (iStart) begin
                if (iTREADY) begin
                    case (sSTATE)
                        stIDLE : begin //we wait for all Layers to have at least one pixel to start
                                    if (wALLLayersDataValid & wALLLayersSOF) begin 
                                        sSTATE        <= stCOL_COUNT;
                                        rHCountGlobal <= 0;
                                        rVCountGlobal <= 0;
                                    end
                                end
                         stCOL_COUNT : begin
                                    // global counter logic
                                    // start
                                             wFIFOREN<='{default: '{default: 1'b0}};
                                            if (~wAtLeastOneLayerDisplay) begin
                                                   rHCountGlobal <= rHCountGlobal+1;
                                                   rMixedCh1     <= iBackRed;
                                                   rMixedCh2     <= iBackGreen;
                                                   rMixedCh3     <= iBackBlue;
                                            end else begin
                                                 for (l=1;l<=pActivelayers;l=l+1) begin
                                                        if (wLayerEnabled(l))
                                                            if (wLayerDataValid[l]) 
                                                                  if (check_data_synched(l,wLayerReadyToDisplay,wLayerDataValid) //all other ready2display have valid  data
                                                                     if (~wFIFODATA[l][lpLAST_BITFIELD]) begin
                                                                        wFIFOREN[l]<='{1,1,1,1};
                                                                        rTVALID   <=1;
                                                                    end 
                                                 end
                                                
                                            end
                                        end
 
                        st_ROW_INC : begin
                                        if (rVCountGlobal===rVCountGlobal+1
                                    end 
                    endcase
                 
                end
            end
        end
    end

endmodule