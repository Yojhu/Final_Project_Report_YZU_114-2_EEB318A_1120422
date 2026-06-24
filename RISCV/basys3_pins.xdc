{\rtf1\ansi\ansicpg950\cocoartf2869
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 ## 1. \uc0\u31995 \u32113 \u26178 \u33032 \u35338 \u34399  (System Clock - 100MHz)\
## ----------------------------------------------------------------------------\
set_property PACKAGE_PIN W5 [get_ports clk]       \
 set_property IOSTANDARD LVCMOS33 [get_ports clk]\
 create_clock -add -name sys_clk_pin -period 10.00 -waveform \{0 5\} [get_ports clk]\
 \
## 2. \uc0\u20027 \u37325 \u32622 \u35338 \u34399  (Master Reset_n - Active Low)\
## ----------------------------------------------------------------------------\
## \uc0\u32004 \u26463 \u22312 \u26368 \u24038 \u20596 \u25351 \u25765 \u38283 \u38364  SW15\u12290 \
## [\uc0\u25805 \u20316 \u25351 \u21335 ]\u65306 \u24448 \u19978 \u25765  (1) \u37323 \u25918 \u37325 \u32622 \u65292 CPU \u25165 \u26371 \u38283 \u22987 \u22519 \u34892  C \u35486 \u35328 \u65288 \u19971 \u27573 \u39023 \u31034 \u22120 \u20142  0000\u65289 \
##             \uc0\u24448 \u19979 \u25765  (0) \u21063 \u30828 \u39636 \u24375 \u21046 \u38263 \u25353 \u37325 \u32622 \u12289 \u34389 \u29702 \u22120 \u23436 \u20840 \u20941 \u32080 \
set_property PACKAGE_PIN R2 [get_ports reset_n]     \
 set_property IOSTANDARD LVCMOS33 [get_ports reset_n]\
\
## 3. \uc0\u25351 \u25765 \u38283 \u38364 \u36664 \u20837  (Slide Switches - SW7 ~ SW0)\
## ----------------------------------------------------------------------------\
set_property PACKAGE_PIN V17 [get_ports \{sw_inputs[0]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[0]\}]\
set_property PACKAGE_PIN V16 [get_ports \{sw_inputs[1]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[1]\}]\
set_property PACKAGE_PIN W16 [get_ports \{sw_inputs[2]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[2]\}]\
set_property PACKAGE_PIN W17 [get_ports \{sw_inputs[3]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[3]\}]\
set_property PACKAGE_PIN W15 [get_ports \{sw_inputs[4]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[4]\}]\
set_property PACKAGE_PIN V15 [get_ports \{sw_inputs[5]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[5]\}]\
set_property PACKAGE_PIN W14 [get_ports \{sw_inputs[6]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[6]\}]\
set_property PACKAGE_PIN W13 [get_ports \{sw_inputs[7]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{sw_inputs[7]\}]\
 \
\
## 4. \uc0\u20116 \u21521 \u25353 \u37397 \u36664 \u20837  (Push Buttons)\
## ----------------------------------------------------------------------------\
## \uc0\u23526 \u27231 \u25509 \u33139 \u30828 \u39636 \u20998 \u37197 \u65306 btn_inputs = \{BTNC, BTNU, BTNL, BTNR, BTND\}\
## btn_inputs[4] -> BTNC (\uc0\u27491 \u20013 \u22830 \u37397 )\u65306 \u20840 \u26032 \u21151 \u33021  ->\u12304 \u37782 \u23384 \u30070 \u21069 \u38283 \u38364 \u25976 \u20540 \u12305 \
set_property PACKAGE_PIN U18 [get_ports \{btn_inputs[4]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{btn_inputs[4]\}]\
## btn_inputs[3] -> BTNU (\uc0\u19978 \u26041 \u21521 \u37397 )\u65306 \u20840 \u26032 \u21151 \u33021  ->\u12304 \u31995 \u32113 \u36575 \u39636 \u27512 \u38646 \u12305 \
set_property PACKAGE_PIN T18 [get_ports \{btn_inputs[3]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{btn_inputs[3]\}]\
## btn_inputs[2] -> BTNL (\uc0\u24038 \u26041 \u21521 \u37397 )\u65306 \u20840 \u26032 \u21151 \u33021  ->\u12304 \u21152 \u27861 \u36939 \u31639 \u37397 \u12305 \
set_property PACKAGE_PIN W19 [get_ports \{btn_inputs[2]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{btn_inputs[2]\}]\
## btn_inputs[1] -> BTNR (\uc0\u21491 \u26041 \u21521 \u37397 )\u65306 \u20840 \u26032 \u21151 \u33021  ->\u12304 \u28187 \u27861 \u36939 \u31639 \u37397 \u12305 \
set_property PACKAGE_PIN T17 [get_ports \{btn_inputs[1]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{btn_inputs[1]\}]\
## btn_inputs[0] -> BTND (\uc0\u19979 \u26041 \u21521 \u37397 )\u65306 \u26997 \u31777 \u29256 \u38290 \u32622 \u19981 \u20351 \u29992 \u65292 \u20294 \u24517 \u38920 \u32173 \u25345 \u32004 \u26463 \u38450 \u27490  DRC \u22577 \u37679 \
set_property PACKAGE_PIN U17 [get_ports \{btn_inputs[0]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{btn_inputs[0]\}]\
 \
\
## 5. LED \uc0\u29128 \u34399 \u36664 \u20986  (LEDs - LD7 ~ LD0)\
## ----------------------------------------------------------------------------\
## led_outputs[0] -> LD0 (\uc0\u37782 \u23384 \u25104 \u21151 \u25351 \u31034 \u29128 \u65306 \u25353 \u20013 \u37749 \u37782 \u23384 \u25976 \u23383 \u26178 \u65292 LD0 \u26371 \u20142 \u36215 )\
set_property PACKAGE_PIN U16 [get_ports \{led_outputs[0]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[0]\}]\
set_property PACKAGE_PIN E19 [get_ports \{led_outputs[1]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[1]\}]\
set_property PACKAGE_PIN U19 [get_ports \{led_outputs[2]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[2]\}]\
set_property PACKAGE_PIN V19 [get_ports \{led_outputs[3]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[3]\}]\
## led_outputs[4] -> LD4 (\uc0\u21152 \u27861 \u25351 \u31034 \u29128 \u65306 \u25353 \u24038 \u37749 \u26178 \u35336 \u25976 \u20006 \u40670 \u20142 )\
set_property PACKAGE_PIN W18 [get_ports \{led_outputs[4]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[4]\}]\
## led_outputs[5] -> LD5 (\uc0\u28187 \u27861 \u25351 \u31034 \u29128 \u65306 \u25353 \u21491 \u37749 \u26178 \u35336 \u25976 \u20006 \u40670 \u20142 \u65292 \u24050 \u25563 \u21040  U15 \u23436 \u20840 \u35299 \u38500 \u34909 \u31361 )\
set_property PACKAGE_PIN U15 [get_ports \{led_outputs[5]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[5]\}]\
set_property PACKAGE_PIN U14 [get_ports \{led_outputs[6]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[6]\}]\
set_property PACKAGE_PIN V14 [get_ports \{led_outputs[7]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{led_outputs[7]\}]\
 \
\
## 6. \uc0\u19971 \u27573 \u39023 \u31034 \u22120 \u65306 \u27573 \u25511 \u21046 \u35338 \u34399  (7 Segment Cathodes - CA ~ CG)\
## ----------------------------------------------------------------------------\
set_property PACKAGE_PIN W7 [get_ports \{cathode[6]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[6]\}]\
set_property PACKAGE_PIN W6 [get_ports \{cathode[5]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[5]\}]\
set_property PACKAGE_PIN U8 [get_ports \{cathode[4]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[4]\}]\
set_property PACKAGE_PIN V8 [get_ports \{cathode[3]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[3]\}]\
set_property PACKAGE_PIN U5 [get_ports \{cathode[2]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[2]\}]\
set_property PACKAGE_PIN V5 [get_ports \{cathode[1]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[1]\}]\
set_property PACKAGE_PIN U7 [get_ports \{cathode[0]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{cathode[0]\}]\
\
\
## 7. \uc0\u19971 \u27573 \u39023 \u31034 \u22120 \u65306 \u25976 \u20301 \u36984 \u25799 \u25511 \u21046 \u35338 \u34399  (4 Digit Anodes - AN3 ~ AN0)\
## ----------------------------------------------------------------------------\
set_property PACKAGE_PIN U2 [get_ports \{anode[0]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{anode[0]\}]\
set_property PACKAGE_PIN U4 [get_ports \{anode[1]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{anode[1]\}]\
set_property PACKAGE_PIN V4 [get_ports \{anode[2]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{anode[2]\}]\
set_property PACKAGE_PIN W4 [get_ports \{anode[3]\}]     \
 set_property IOSTANDARD LVCMOS33 [get_ports \{anode[3]\}]\
\
## ============================================================================\
## \uc0\u22739 \u32302  Bitstream \u33287 \u37197 \u32622 \u23660 \u24615  (FPGA \u23526 \u27231 \u37197 \u32622 \u23560 \u29992 )\
## ============================================================================\
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]\
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]\
set_property CONFIG_MODE SPIx4 [current_design]}