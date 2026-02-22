module VideoMixerV20 #(
    parameter pActiveLayers       = 2, //less or equal than available ports
    parameter pColorWidth         = 8,
    parameter pPPC                = 1,
    parameter pMonitorHres        = 1920,
    parameter pMonitorVres        = 1080,
    parameter pNChannels          = 4,
    parameter pMaxLayers          = 2
)
(
    //Globals
    input                                               iPixClk,
    input                                               iPixRstn,
    
    input           [$clog2(pMonitorHres)-1:0]          iHRESBack,
    input           [$clog2(pMonitorVres)-1:0]          iVRESBack,

    //CTRL is assumed to be synchronous to Pix Clk
    input                                               iSWResetN,
    input                                               iStart,
    input                                               iStop,
    output                                              oInt,

    //Background Layer
    input           [pColorWidth-1:0]                   iBackRed,
    input           [pColorWidth-1:0]                   iBackGreen,
    input           [pColorWidth-1:0]                   iBackBlue,

    //Layer 1
    input           [$clog2(pMonitorHres)-1:0]          iPanX1, //0based
    input           [$clog2(pMonitorVres)-1:0]          iPanY1,
    input           [$clog2(pMonitorHres)-1:0]          iHRES1,
    input           [$clog2(pMonitorVres)-1:0]          iVRES1,
    input                                               iLayer1En,

    input           [(pPPC)*(pNChannels)*pColorWidth-1:0] iTDATA1,
    input                                               iTVALID1,
    input                                               iTLAST1,
    input                                         iTUSER1,
    output                                              oTREADY1,

    //Layer 2
    input           [$clog2(pMonitorHres)-1:0]          iPanX2,
    input           [$clog2(pMonitorVres)-1:0]          iPanY2,
    input           [$clog2(pMonitorHres)-1:0]          iHRES2,
    input           [$clog2(pMonitorVres)-1:0]          iVRES2,
    input                                               iLayer2En,

    input           [(pPPC)*(pNChannels)*pColorWidth-1:0] iTDATA2,
    input                                               iTVALID2,
    input                                               iTLAST2,
    input                                      iTUSER2,
    output                                              oTREADY2,

    // Output
    output          [(pPPC)*(3)*pColorWidth-1:0]        oTDATA,
    output                                              oTVALID,
    output                                              oTLAST,
    output                                        oTUSER,
    input                                               iTREADY
);

 localparam int lpMAXHRES        = 4096;
    localparam int lpMAXVRES        = 2160;
    localparam int lpURAMDepth      = 64;
    localparam int lpURAMWidth      = 12;
    localparam int lpFifoWidth      = lpURAMWidth;
    localparam int lpFifoDepth      = lpURAMDepth;
    localparam int lpFifoPadNBit    = lpURAMWidth - ( pColorWidth + 1 );
    localparam int lpNumStates      = 3;
    localparam     stIDLE           = 0;
    localparam     stCOL_COUNT      = 1;
    localparam     st_ROW_INC       = 2;
    localparam int lpUSER_BITFIELD  = 0; //in FIFO DATA PACKING
    localparam int lpLAST_BITFIELD  = 1;

    function int check_data_synched (input int actual_index, input Ready2Display [1:pActiveLayers], input FifoDataValid [1:pActiveLayers]);
        for (int i = 1; i <= pActiveLayers; i++) begin
            if (i != actual_index && (Ready2Display[i] == 1) ) begin
                if (!FifoDataValid[i]) begin
                    return 0;
                end
            end
        end
        return 1;
    endfunction

   

    //PARAMETERS
    reg     [(pPPC)*(3)*pColorWidth-1:0]    rTDATA;
    reg                                     rTVALID;
    reg                                     rTLAST;
    reg                                     rTUSER;

    reg             [pColorWidth-1:0]       rBackRed;
    reg             [pColorWidth-1:0]       rBackGreen;
    reg             [pColorWidth-1:0]       rBackBlue;
    
    // Position and Size Registers
    reg     [$clog2(lpMAXHRES)-1:0]         rPANX [1:pMaxLayers];
    reg     [$clog2(lpMAXHRES)-1:0]         rPANX2 [1:pMaxLayers]; // Pre-calculated End X
    reg     [$clog2(lpMAXVRES)-1:0]         rPANY [1:pMaxLayers];
    reg     [$clog2(lpMAXVRES)-1:0]         rPANY2 [1:pMaxLayers]; // Pre-calculated End Y
    reg     [$clog2(lpMAXHRES)-1:0]         rHRES [1:pMaxLayers];
    reg     [$clog2(lpMAXVRES)-1:0]         rVRES [1:pMaxLayers];
    reg                                     rLayerEnabled [1:pMaxLayers];

    //INTERNAL COUNTERS and UTIL signals
    reg     [$clog2(lpMAXHRES)-1:0]         rHCountGlobal;
    reg     [$clog2(lpMAXVRES)-1:0]         rVCountGlobal;
    wire                                    wSW_HW_RSTN;
    reg                                     rInternalRSTN;
    reg     [$clog2(lpNumStates)-1:0]       rSTATE;

    //Stream/Channels declarations
    reg     [$clog2(lpMAXHRES)-1:0]         rHCountLayer [1:pActiveLayers];
    reg     [$clog2(lpMAXVRES)-1:0]         rVCountLayer [1:pActiveLayers];

   // reg     [pColorWidth-1:0]               rMixedCh1;
   // reg     [pColorWidth-1:0]               rMixedCh2;
   // reg     [pColorWidth-1:0]               rMixedCh3;
   // reg     [pColorWidth-1:0]               rMixedAlpha;
   
   
   reg 										rLAST;
   reg 										rVALID;
   reg 										rSHOWBACKGROUND;
    
    wire    [pColorWidth-1:0]               wDATA [1:pMaxLayers][1:pNChannels];
    wire                                    wVALID [1:pMaxLayers];
    wire                                    wLAST [1:pMaxLayers];
    wire                                    wUSER [1:pMaxLayers];
    
    reg     [lpFifoWidth+2-1:0]             wFIFODATA [1:pActiveLayers][1:pNChannels];
    wire                                    wFIFOVALID [1:pActiveLayers][1:pNChannels];
    reg                                     rFIFOREN [1:pActiveLayers][1:pNChannels]; 
    wire                                    wFIFOREN [1:pActiveLayers][1:pNChannels];
    wire                                    wFIFOEMPTY [1:pActiveLayers][1:pNChannels];
    wire                                    wFIFOFULL [1:pActiveLayers][1:pNChannels];
    
    reg                                     rERROR [1:pActiveLayers];

    wire                                    wLayerDataValid [1:pActiveLayers];
   // wire                                    wLayerREN [1:pActiveLayers];
    wire                                    wLayerSOF [1:pActiveLayers];
  //  reg                                     rLayerRENTmp [1:pActiveLayers];
    wire                                    wREADY [1:pActiveLayers];
    reg                                     rALLLayersDataValid;
    reg                                     rALLLayersSOF;
 //   wire                                    wREADY4ALL;

    wire                                    wLayerReadyToDisplay [1:pActiveLayers]; //means enabled and in the pan period
   // wire                                    wLayerReadyToDisplayOtherThanMe [1:pActiveLayers];
    reg                                     rAtLeastOneLayerDisplay;
    reg                                     rALLLayersDisabled;

    assign          wSW_HW_RSTN             = iPixRstn & iSWResetN;

    // ASSIGN INPUT TO INDEXED ARRAYS
    genvar s;
    generate
        for (s=1; s<=pNChannels; s=s+1) begin : Gen_assign_channels_layer1
            assign      wDATA[1][s]         = iTDATA1[(s)*pColorWidth-1:(s-1)*pColorWidth];
        end
    endgenerate
    
    assign              wVALID[1]           = iTVALID1;
    assign              wLAST[1]            = iTLAST1;
    assign              wUSER[1]            = iTUSER1;
    assign              oTREADY1            = wREADY[1];

    generate
        for (s=1; s<=pNChannels; s=s+1) begin : Gen_assign_channels_layer2
            assign      wDATA[2][s]         = iTDATA2[(s)*pColorWidth-1:(s-1)*pColorWidth];
        end
    endgenerate

    assign              wVALID[2]           = iTVALID2;
    assign              wLAST[2]            = iTLAST2;
    assign              wUSER[2]            = iTUSER2;
    assign              oTREADY2            = wREADY[2];

    //Latching dynamic parameter at the EOF
    always @(posedge iPixClk)
    begin : ParamsLatch
        if (!wSW_HW_RSTN) begin
			rBackRed   	 <= 0;
			rBackGreen   <= 0;
			rBackBlue    <= 0;
			
            rPANX[1] 	<= 0; 
            rPANX2[1] 	<= 0; 
            rPANY[1] 	<= 0;
            rPANY2[1] 	<= 0;
            rHRES[1] 	<= 0;
            rVRES[1] 	<= 0;
            
            rPANX[2] 	<= 0;
            rPANX2[2] 	<= 0;
            rPANY[2] 	<= 0;
            rPANY2[2] 	<= 0;
            rHRES[2] 	<= 0; 
        end 
        else if (rSTATE == stIDLE) begin
			rBackRed   	 <= iBackRed;
			rBackGreen   <= iBackGreen;
			rBackBlue    <= iBackBlue;
			
            // Layer 1
            rPANX[1]         <= iPanX1 ; 
            rPANX2[1]        <= iPanX1 + iHRES1 - 1;
            rPANY[1]         <= iPanY1;
            rPANY2[1]        <= iPanY1 + iVRES1 - 1;
            rHRES[1]         <= iHRES1;
            rVRES[1]         <= iVRES1;
            rLayerEnabled[1] <= iLayer1En;

            // Layer 2
            rPANX[2]         <= iPanX2 ;
            rPANX2[2]        <= iPanX2 + iHRES2 - 1;
            rPANY[2]         <= iPanY2;
            rPANY2[2]        <= iPanY2 + iVRES2 - 1;
            rHRES[2]         <= iHRES2;
            rVRES[2]         <= iVRES2;
            rLayerEnabled[2] <= iLayer2En;
        end
    end

    integer f;
    always @(*) begin
        rALLLayersDataValid         = 1; //all layers fifo have a valid data available
        rALLLayersSOF               = 1; // all layers fifo data is the SOF
        rAtLeastOneLayerDisplay     = 0;
        rALLLayersDisabled          = 1;
        
        for (f=1; f<=pActiveLayers; f=f+1) begin
            rALLLayersDataValid         = rALLLayersDataValid           & wLayerDataValid[f];
            rALLLayersSOF               = rALLLayersSOF                 & wLayerSOF[f];
            rAtLeastOneLayerDisplay     = rAtLeastOneLayerDisplay       | wLayerReadyToDisplay[f];
            rALLLayersDisabled          = rALLLayersDisabled            & ~rLayerEnabled[f];
        end
    end
    
    genvar i, k;
    generate
        for (k=1; k<=pActiveLayers; k=k+1) begin : Gen_KLayer
            
            assign wREADY[k]                    = ~wFIFOFULL[k][1];
            assign wLayerDataValid[k]           = wFIFOVALID[k][1];
            assign wLayerSOF[k]                 = wFIFODATA[k][1][0]; 
            // Updated logic using rPANX2/rPANY2
            assign wLayerReadyToDisplay[k]      = (rLayerEnabled[k]==1 && (rHCountGlobal >= rPANX[k] && rHCountGlobal <= rPANX2[k]) && (rVCountGlobal >= rPANY[k] && rVCountGlobal <= rPANY2[k]) ) ? 1 : 0;

            for (i=1; i<=pNChannels; i=i+1) begin : Gen_iChannel_kLayer
                
                assign wFIFOREN[k][i] = rFIFOREN[k][i]  & iTREADY;// 

                URAM_MIXER iChannelFIFOStreamK (
                    // Inputs
                    .DATA       ({wDATA[k][i], wLAST[k], wUSER[k]}),
                    .RCLOCK     (iPixClk),
                    .RE         (wFIFOREN[k][i]),
                    .RRESET_N   (wSW_HW_RSTN),
                    .WCLOCK     (iPixClk),
                    .WE         (wVALID[k] & ~wFIFOFULL[k][i]),
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

    always @(posedge iPixClk)
    begin : MainIterator
        if (!wSW_HW_RSTN) begin

            rHCountGlobal       <= 0;
            rVCountGlobal       <= 0;
            rHCountLayer        <= '{default:0};
            rVCountLayer        <= '{default:0};
            rSTATE              <= stIDLE;
            rInternalRSTN       <= 1;
            rFIFOREN            <= '{default:'{default:1'b0}};
            rERROR              <= '{default:0};
			rLAST 				<= 0;
			rVALID 				<= 0;
			rSHOWBACKGROUND     <= 0;
          
        end else begin
            if (iStart) begin
                if (iTREADY) begin
                    case (rSTATE)
                        stIDLE : begin 
                            rInternalRSTN       <= 1;
                            rERROR              <= '{default:0};
							rLAST 				<= 0;
							rVALID 				<= 0;
							rSHOWBACKGROUND     <= 0;
                            if (rALLLayersDataValid & rALLLayersSOF) begin
                                rSTATE          <= stCOL_COUNT;
                                rHCountGlobal   <= 0;
                                rVCountGlobal   <= 0;
                            end
                        end
                        
                        stCOL_COUNT : begin
                            rFIFOREN <= '{default:0};
                            rLAST 				<= 0;
							rVALID 				<= 0;
							rSHOWBACKGROUND     <= 0;
                            if (~rAtLeastOneLayerDisplay) begin
                                // IF THERE IS NOTHING TO DISPLAY I MOVE ON WITH BACKGROUND
                                rHCountGlobal <= rHCountGlobal + 1;
								rVALID 				<= 1;
								rSHOWBACKGROUND     <= 1;
                                if (rHCountGlobal == iHRESBack) begin
                                     rHCountGlobal <= 0;
									 rVALID 				<= 0;
                                     rVCountGlobal <= rVCountGlobal + 1;
                                     rSTATE        <= st_ROW_INC;
                                     if (rVCountGlobal == pMonitorVres - 1) begin 
                                         rVCountGlobal <= 0;
                                     end
                                end else if (rHCountGlobal == iHRESBack-1) begin
									 rLAST 		   <= 1;
								end
                            end else begin

                                logic [1:pActiveLayers] rIncGlobal;

                                for (l=1; l<=pActiveLayers; l=l+1) begin
                                    rIncGlobal[l] = 0; // Initialize
                                    if (rLayerEnabled[l]) begin 
                                        if (wLayerDataValid[l]) begin
                                            // IF I AM VALID AND ALL OTHERS READYTODISPLAY ARE VALID
                                            rIncGlobal[l] = check_data_synched(l, wLayerReadyToDisplay, wLayerDataValid);
                                          
                                            if (rIncGlobal[l]) begin
												
                                                 if (~wFIFODATA[l][1][lpLAST_BITFIELD]) begin 
                                                     rFIFOREN[l] <= '{default:1}; // Read all channels
                                                     rHCountLayer[l] <= rHCountLayer[l] + 1;
													// $display("rIncGlobal[%d] = %d\n",l, rIncGlobal[l]);
                                                 end
												 /* when we have last ready to display is low
												 else begin //IF LAST
                                                     rHCountLayer[l] <= 0;
													 $display("LAST rIncGlobal[%d] = %d\n",l, rIncGlobal[l]);
                                                     rVCountLayer[l] <= rVCountLayer[l] + 1;
                                                     if (rVCountLayer[l] == rVRES[l]-1) rVCountLayer[l] <= 0;
                                                 end
												 */
                                            end
                                        end
                                    end
                                end
                                
                                // Global Increment kepps running is layers are displaying
                                if (|rIncGlobal) begin
                                     rHCountGlobal <= rHCountGlobal + 1;
									 rVALID 				<= 1;
									 
                                     if (rHCountGlobal == iHRESBack) begin
                                         rHCountGlobal <= 0;
										 rVALID 				<= 0;
                                         rVCountGlobal <= rVCountGlobal + 1;
                                         rSTATE <= st_ROW_INC;
                                         if (rVCountGlobal == pMonitorVres - 1) begin
                                            rVCountGlobal <= 0;
                                         end
                                     end else if (rHCountGlobal == iHRESBack-1) begin
									 rLAST 		   <= 1;
									end
                                end
                            end
                        end
                        
                        st_ROW_INC : begin 
							 rLAST 				  <= 0;
							  rVALID 			  <= 0;
							  rSHOWBACKGROUND     <= 0;
                             if (rVCountGlobal == 0) begin
                                 rSTATE <= stIDLE;
								 
                                 for (l=1; l<=pActiveLayers; l=l+1) begin
                                      rERROR[l] <= ~wFIFOEMPTY[l][1]; 
                                      assert (~rERROR[l]) else $error ("FIFO[%d] not empty after last bit", l);
                                 end
                             end else begin
                                 rSTATE <= stCOL_COUNT;
                             end
                        end
                    endcase
                end
            end
        end
    end
    
    // OUTPUT ASSIGNMENTS
    assign oTDATA   = (rSHOWBACKGROUND ) ? {iBackRed,iBackGreen,iBackBlue} :
					  {wFIFODATA[1][3][pColorWidth+2-1:2], wFIFODATA[1][2][pColorWidth+2-1:2], wFIFODATA[1][1][pColorWidth+2-1:2]};
    assign oTVALID  = rVALID;
    assign oTLAST   = rLAST;
    assign oTUSER   = (rVALID==1 && rHCountGlobal==1 && rVCountGlobal==0)? 1 : 0;
    
endmodule