module DMFB_Train_Datapath (clock,act_N,reset_N,next,clr_t,tout,voltageActuation,
					src[3:0],dest[3:0],
					A1[3:0],A2[3:0],A3[3:0],A4[3:0],reachDest,
					display1[6:0],display2[6:0],display3[6:0],display4[6:0],display5[9:0],
					display6[6:0],display7[6:0],display8[6:0],display9[6:0],clockControl,dropletSelect);
// PI and PO
input clock;
input act_N;
input reset_N;
input next;
input clr_t;

output tout;

input voltageActuation;
input [3:0] src;
input [3:0] dest;
//input [2:0] offset;

output [3:0] A1;
output [3:0] A2;
output [3:0] A3;
output [3:0] A4;

output reachDest;

output [6:0] display1;
output [6:0] display2;
output [6:0] display3;
output [6:0] display4;

output [9:0] display5;

output [6:0] display6;
output [6:0] display7;
output [6:0] display8;
output [6:0] display9;

input clockControl;
input dropletSelect;

wire [6:0] disp1,disp2,disp3,disp4,disp6,disp7,disp8,disp9;
wire [3:0] addr1,addr2,addr3,addr4,addr5,addr6;

wire [9:0] disp5;
wire [15:0] addr_bus;

assign addr1 = src;
assign addr2 = dest;
assign addr3 = A1;
assign addr4 = A2;
assign addr5 = A3;
assign addr6 = A4;

assign display1 = disp1;
assign display2 = disp2;
assign display3 = disp3;
assign display4 = disp4;

assign display5 = disp5;

assign display6[6:0] = disp6[6:0];
assign display7[6:0] = disp7[6:0];
assign display8[6:0] = disp8[6:0];
assign display9[6:0] = disp9[6:0];

assign addr_bus[3:0] = addr6[3:0];
assign addr_bus[7:4] = addr5[3:0];
assign addr_bus[11:8] = addr4[3:0];
assign addr_bus[15:12] = addr3[3:0];

// NextMoveGenerator Module instance N0
//NextMoveGenerator			N0 (act_N,reset_N,next,src[3:0],dest[3:0],offset[2:0],A1[3:0],A2[3:0],A3[3:0],A4[3:0],reachDest);
NextMoveGenerator			N0 (act_N,reset_N,next,src[3:0],dest[3:0],A1[3:0],A2[3:0],A3[3:0],A4[3:0],reachDest,dropletSelect);

// xTimer Module instance T0
xTimer 	            		T0 (clr_t,clock,clockControl,tout);

// Seven segment Display_Generator instance D1 for source address
Display_Generator 			D1(clock,act_N,addr1,disp1);

// Seven segment Display_Generator instance D2 for destination address
Display_Generator 			D2(clock,act_N,addr2,disp2);

// Seven segment Display_Generator instance D3 for actuation address1 (A1)
//Display_Generator 			D3(clock,act_N,addr3,disp3);
//Display_Generator 			D3(clock,act_N,4'b1111,disp3);
Display_Generator D3(clock,act_N,4'b1111,disp3);

// Seven segment Display_Generator instance D4 for actuation address1 (A2)
//Display_Generator 			D4(clock,act_N,addr4,disp4);
Display_Generator D4(clock,act_N,4'b1111,disp4);

Display_Generator D6(clock,act_N,addr3,disp6);
Display_Generator D7(clock,act_N,addr4,disp7);
Display_Generator D8(clock,act_N,addr5,disp8);
Display_Generator D9(clock,act_N,addr6,disp9);

// Train_Display_Generator instance D5 for 10 LED set dummy DMFB cell actuation prototype
//Train_Display_Generator 	D5(clock,voltageActuation,addr_bus,disp5);
Train_Display_Generator D5(clock,voltageActuation,addr_bus[15:0],disp5[9:0]);




endmodule 