module Display_Generator(clock,act_D,addr[3:0],disp7[6:0]);
	
	// PI and PO
	input act_D;
	input clock;
	input [3:0] addr;

		
	output [6:0] disp7; 
	
	reg [6:0] disp7;

always @(posedge clock)
	if(act_D == 1) begin
		case(addr)

		4'b0000:	disp7 <= 7'b1000000;  // '0'
		4'b0001:	disp7 <= 7'b1111001;  // '1'
		4'b0010:	disp7 <= 7'b0100100;  // '2'
		4'b0011:	disp7 <= 7'b0110000;  // '3'
		4'b0100:	disp7 <= 7'b0011001;  // '4'
		4'b0101:	disp7 <= 7'b0010010;  // '5'
		4'b0110:	disp7 <= 7'b0000010;  // '6'
		4'b0111:	disp7 <= 7'b1111000;  // '7'
		4'b1000:	disp7 <= 7'b0000000;  // '8'
		4'b1001:	disp7 <= 7'b0010000;  // '9'
		default:	disp7 <= 7'b1111111;  // Number other than 0-9 is not displayed 

/*		0:	disp7 <= 7'b0000001;  // '0'
		1:	disp7 <= 7'b1001111;  // '1'
		2:	disp7 <= 7'b0010010;  // '2'
		3:	disp7 <= 7'b0000110;  // '3'
		4:	disp7 <= 7'b1001100;  // '4'
		5:	disp7 <= 7'b0100100;  // '5'
		6:	disp7 <= 7'b0100000;  // '6'
		7:	disp7 <= 7'b0001111;  // '7'
		8:	disp7 <= 7'b0000000;  // '8'
		9:	disp7 <= 7'b0000100;  // '9'
		default:	disp7 <= 7'b1111111;  // Number other than 0-9 is not displayed 
*/

		endcase
	end	
endmodule
