//module DMFB_Train_Controller(clock,enable,reset,reachDest,time_out,act_N,reset_N,next,act_t,clr_t,voltageActuation);
//module DMFB_Train_Controller(debug,clock,enable,reset,reachDest,time_out,act_N,reset_N,next,clr_t,voltageActuation);
module DMFB_Train_Controller(clock,enable,reset,reachDest,time_out,act_N,reset_N,next,clr_t,voltageActuation);
		// PI
		//input debug;
		input clock;
		input enable;
		input reset;
		
		// input from NextMoveGenerator module
		input reachDest;
		
		// input from xTimer module
		input time_out;
		//output time_out;
		
		// PO
		output voltageActuation;
		
		// controlling pins for NextMoveGenerator module
		output act_N;
		output reset_N;
		output next;		
		
		// controlling pins for xTimer module
		//output act_t;
		output clr_t;						

		// internal registers
		reg act_N;
		reg reset_N;
		reg next;

		reg act_t;
		reg clr_t;
		reg voltageActuation;
		
		reg [2:0] stateCurrent;
		//reg [1:0] state;
		
		// state definition
//		parameter start=2'b00, nextMove=2'b01, applyVoltage=2'b10, done=2'b11;
		parameter start=3'b000, resetMove=3'b001, nextMove=3'b010, applyVoltage=3'b011, done=3'b100;


/*		
		wire reset_t,tout;	
		xTimer 	            T0 (reset_t,clock,tout);		
		assign reset_t = clr_t;
		assign time_out = tout;
*/

		
//always @(negedge clock)
always @(posedge clock)
//always @(negedge debug)
		begin
			if (enable==1) begin
			
				if (reset==1) begin				
					stateCurrent <= start;	// go to initial state
				end								
			end
			
			else stateCurrent <= done; 

// --------- state machine --------------
			
			case (stateCurrent)
			
			start: begin
					   if (enable==1) begin
							voltageActuation <= 0; 	// voltageActuation clear
							clr_t <= 1;				// xTimer clear or reset
							
							act_N <= 1;
							reset_N <= 1;			// NextMoveGenerator reset
							
							next <= 1;				// NextMoveGenerator next pin set for actuation
							
							stateCurrent <= resetMove;	// to keep the reset mode set for NextMoveGenerator
						 
						 end							// plz remove if following code set enabled
						 	
/*							if(reset==1) begin
									stateCurrent <= start;	// go to initial state
							end
							
							else begin

							if (reachDest!=1) begin
								stateCurrent <= nextMove;
							end							

							else
								stateCurrent <= done;
							
							end
							
					   end
					   else stateCurrent <= done;
*/

				   end


			resetMove: begin

					   	if (enable==1) begin
							voltageActuation <= 0; 	// voltageActuation clear
							clr_t <= 1;				// xTimer clear or reset
							
							act_N <= 1;
							reset_N <= 1;			// NextMoveGenerator reset
							
							next <= 0;				// NextMoveGenerator next pin set for actuation
					   
							if(reset==1) begin
									stateCurrent <= start;	// go to initial state
							end
							
							else begin

								if (reachDest!=1) begin
									stateCurrent <= nextMove;
								end							

								else
									stateCurrent <= done;
								
							end
							
					   end

					   else stateCurrent <= done;
				
				
				end
				
			nextMove: begin
				   
				   voltageActuation <= 0;
				   reset_N <= 0;
				   next <= 0;
				   
						 if (enable==1) begin
							
							if(reset==1) begin
									stateCurrent <= start;	// go to initial state
							end
							
							else begin
						  
							if (reachDest!=1) begin

								//voltageActuation <= 0; 	// voltageActuation clear
								//reset_N <= 0;
								//next <= 0;			// negedge next will activate NextMoveGenerator
								
								voltageActuation <= 1;
								clr_t <= 0;
								stateCurrent <= applyVoltage;
							end
							
							else
								stateCurrent <= done;
							
							end
							
						  end
						  
						  else 
							stateCurrent <= done;
				   end
				   
			applyVoltage: begin
				   
					  voltageActuation <= 1; 	// voltageActuation clear
 					  clr_t <= 0;  
					  
					  if (enable==1) begin
					   
							if(reset==1) begin
								stateCurrent <= start;	// go to initial state
							end
				   
							else begin
								if (time_out==1) begin
									next <= 1;
									clr_t <= 1;
									
									voltageActuation <= 0;
									stateCurrent <= nextMove;
								end							
															
								else begin
									// voltageActuation <= 1; 	// voltageActuation clear
									// clr_t <= 0;
									
									stateCurrent <= applyVoltage;
								end
							
							end
							
						end
						else stateCurrent <= done;	
					   					  
					   
				   end
				    
			done: begin

						voltageActuation <= 0; 	// voltageActuation clear
						clr_t <= 1;				// xTimer clear or reset
						
						act_N <= 1;
						reset_N <= 0;			// NextMoveGenerator reset
						
										  
					if (enable==1) begin
						//stateCurrent <= start;	// go to initial state
						
						if(reset==1) begin
							stateCurrent <= start;	// go to initial state
						end
						
						else stateCurrent <= done;
				
					end

					else stateCurrent <= done;
						   
				  end
			
			default: stateCurrent <= done;

			endcase
		end
endmodule 

// --------- state machine --------------
