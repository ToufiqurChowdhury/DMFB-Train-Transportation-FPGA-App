module xTimer(reset_t,clockIn,clockControl,clockOut);
	
	// PI and PO
	input reset_t;

	input clockIn;
	
	input clockControl;
		
	output clockOut;
	
	//parameter delay_t = 15000000*2;
	parameter delay_t = 0;						 // delay for adjustment
		
		
	parameter clkPeriod1 = (1500000*2) - delay_t; // 60 ms clock, 3 MHz, N=21
	parameter clkPeriod2 = (200000000) - delay_t; // 2 s clock, 200 MHz, N=27

	//parameter clkPeriod2 = 5 - delay_t; 

	
	parameter clkPeriodHalf1 = clkPeriod1 / 2;
	
	parameter clkPeriodHalf2 = clkPeriod2 / 2;
	
	parameter N = 27; // N = roundUp(ln DF / ln 2) -1 = 21-1

	//parameter N = 3;
	
	reg [N:0] counter;
	reg clockOut;
	
//	always @(posedge clockIn)
	always @(negedge clockIn)
	begin
		if(reset_t) begin	
			counter <= 0;
			clockOut <= 0;
		end
		
		else begin
			if (clockControl==1)begin
			   if(counter == clkPeriod2-1) begin
					counter <= 0;
					clockOut <= 0;
				end
				
				else 
					counter <= counter + 1;
				
				if (counter == clkPeriodHalf2)
					clockOut <= 1;
			end
		
			else begin
				   if(counter == clkPeriod1-1) begin
						counter <= 0;
						clockOut <= 0;
					end
					
					else 
						counter <= counter + 1;
					
					if (counter == clkPeriodHalf1)
						clockOut <= 1;
			
			end
		end
	end
endmodule
