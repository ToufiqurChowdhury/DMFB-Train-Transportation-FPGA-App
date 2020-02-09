module NextMoveGenerator(act_N,reset_N,next,src[3:0],dest[3:0],A1[3:0],A2[3:0],A3[3:0],A4[3:0],
						reachDest,dropletSelect);

// PI and PO
input act_N;
input reset_N;
input next;

input [3:0]src;
input [3:0]dest;

output [3:0]A1;
output [3:0]A2;
output [3:0]A3;
output [3:0]A4;

output reachDest;

input dropletSelect;

reg [3:0] A1;
reg [3:0] A2;
reg [3:0] A3;
reg [3:0] A4;

reg reachDest;

// internal registrars
reg [3:0] locCurrent;
reg [3:0] locEnd;
reg [1:0] count_N;
reg [2:0] dropletCount;


always @(negedge next)
//always @(posedge next)
//always @(posedge clock)
		begin
		
	if (reset_N==1 && src < dest) begin			// module active and reset pin for init
			reachDest <= 0;
			A1 <= 4'b0;
			A2 <= 4'b0;
			
			locCurrent <= src;
			locEnd <= dest;
			count_N = 0;
			
			if(dropletSelect==1) begin
				dropletCount <= 4'b0100;
				A3 <= 4'b0;
				A4 <= 4'b0;			
			end
			else begin
				dropletCount <= 4'b0010;
				A3 <= 4'b1111;
				A4 <= 4'b1111;
			
			end
		
		end
		
		else if(act_N==1 && src < dest) begin		// module active and next pin for next moves (A1 and A2) generator
			//reachDest = 1;		// debug code
		
			if (locCurrent+(dropletCount-2)==locEnd)			// module reach destination pin out
				reachDest <= 1;
				
			else if (count_N==0) begin		// count_N generates the destination addresses  
				
				if (dropletSelect==1) begin
					//count_N = count_N +1;
					A1 = locCurrent + count_N;				
					count_N = count_N +1;
					
					A2 = locCurrent + count_N;				
					//locCurrent <= A2;	
					count_N = count_N +1;
					
					A3 = locCurrent + count_N;				
					//locCurrent <= A3;	
					count_N = count_N +1;
					
					A4 = locCurrent + count_N;				
					
					locCurrent <= A1 + 1;	
/*---------------------				
				if (count_N == offset-1) begin	// count_N is clear when equal to (offset-1)
					count_N <=0;
					//reachDest = 0;
*/
				//count_N <= count_N - offset;
				
				end
				
				else begin
					A1 = locCurrent + count_N;				
					count_N = count_N +1;
					
					A2 = locCurrent + count_N;				
					
					locCurrent <= A1 + 1;	
				
				end

				if (count_N == dropletCount-1) begin	// count_N is clear when equal to (offset-1)
					count_N <=0;

				end	
				
			end
			
		end
		
		else reachDest <= 1;				// src can not be greater than dest, else rechDest is positive

	end

endmodule 