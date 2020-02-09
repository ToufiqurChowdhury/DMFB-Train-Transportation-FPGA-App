module DMFBTrainMoveVoltageGenerator(clock,enable,reset,voltageActuation,
					src[3:0],dest[3:0],A1[3:0],A2[3:0],A3[3:0],A4[3:0],reachDest,
					display1[6:0],display2[6:0],display3[6:0],display4[6:0],display5[9:0],
					display6[6:0],display7[6:0],display8[6:0],display9[6:0],clockControl,dropletSelect);

// PI and PO

// Controller
input clock;
input enable;
input reset;
//input reachDest;
//input time_out;

//output act_N;
//output reset_N;
//output next;	
//output clr_t;
//output tout;

output voltageActuation;

// xTimer
//input reset_t;

// NextMoveGenerator
input [3:0]src;
input [3:0]dest;
//input [2:0]offset;

output [3:0]A1;
output [3:0]A2;
output [3:0]A3;
output [3:0]A4;
output reachDest;

// Display pins
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

wire act_N;
wire reset_N;
wire next;	
wire clr_t;
wire tout;

// Controller Module instance C0
DMFB_Train_Controller 	C0 (clock,enable,~reset,reachDest,tout,act_N,reset_N,next,clr_t,voltageActuation);

// Datapath Module instance D0
DMFB_Train_Datapath 	D0 (clock,act_N,reset_N,next,clr_t,tout,voltageActuation,src[3:0],dest[3:0],A1[3:0],A2[3:0],A3[3:0],A4[3:0],reachDest,display1[6:0],display2[6:0],display3[6:0],display4[6:0],display5[9:0],display6[6:0],display7[6:0],display8[6:0],display9[6:0],clockControl,dropletSelect);

endmodule 