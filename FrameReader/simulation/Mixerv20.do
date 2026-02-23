onerror {resume}
quietly virtual signal -install /FrameRD_TB/FrameRD_0/VideoMixerV20_0 {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rFIFOREN[1][1]  } READ_EN1
quietly virtual signal -install {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK} {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA[1]  } DATA1_LAST
quietly virtual signal -install {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK} { /FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA[11:2]} DATA1
quietly virtual signal -install {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK} {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/Q[1]  } DATA_FIFO_LAST
quietly virtual signal -install {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK} { /FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/Q[11:2]} DATA_FIFO
quietly virtual signal -install /FrameRD_TB/FrameRD_0/VideoMixerV20_0 {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rFIFOREN[2][1]  } REN2
quietly virtual signal -install {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK} { /FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/Q[11:2]} DATA_FIFO2
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rVRES
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHRES
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rPANY2
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rPANY
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rPANX2
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rPANX
add wave -noupdate -divider S_AXIS1
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTDATA1
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTVALID1
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTREADY1
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTLAST1
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTUSER1
add wave -noupdate -divider S_AXIS2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTDATA2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTVALID2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTREADY2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTLAST2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTUSER2
add wave -noupdate -divider M_AXIS
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTVALID
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTDATA
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTLAST
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/oTUSER
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/iTREADY
add wave -noupdate -divider FIFO1_1
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RCLOCK}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RE}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RRESET_N}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WCLOCK}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WE}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WRESET_N}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DVLD}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/EMPTY}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/FULL}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA_FIFO_LAST}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA_FIFO}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[1]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/Q}
add wave -noupdate -divider FIFO2_1
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RCLOCK}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RE}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/RRESET_N}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WCLOCK}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WE}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/WRESET_N}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DVLD}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/EMPTY}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/FULL}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/DATA_FIFO2}
add wave -noupdate {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/Gen_KLayer[2]/Gen_iChannel_kLayer[1]/iChannelFIFOStreamK/Q}
add wave -noupdate -divider STATEMACHINE
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rSTATE
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rSHOWBACKGROUND
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/REN2
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/READ_EN1
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountGlobal
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rVCountGlobal
add wave -noupdate -radix unsigned -childformat {{{/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountLayer[1]} -radix unsigned} {{/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountLayer[2]} -radix unsigned}} -expand -subitemconfig {{/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountLayer[1]} {-height 15 -radix unsigned} {/FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountLayer[2]} {-height 15 -radix unsigned}} /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rHCountLayer
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rVCountLayer
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/wFIFODATA
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rERROR
add wave -noupdate -expand /FrameRD_TB/FrameRD_0/VideoMixerV20_0/wLayerDataValid
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/wLayerSOF
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/wREADY
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rALLLayersDataValid
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rALLLayersSOF
add wave -noupdate -expand /FrameRD_TB/FrameRD_0/VideoMixerV20_0/wLayerReadyToDisplay
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rAtLeastOneLayerDisplay
add wave -noupdate /FrameRD_TB/FrameRD_0/VideoMixerV20_0/rALLLayersDisabled
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5239392500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 233
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5239230141 ps} {5239697425 ps}
