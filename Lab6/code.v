//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072 = 0010 0101 0100 0000
// Bits menos significativos: 0100 0000
// 26/Agosto/2020
// Uso de multiplexores
// -----------------------------------


// Flip Flop de 4 entradas 

module flip_flop(input wire clk, reset, set,
				 input wire[3:0] d, 
				 output reg[3:0] q);	
	always @ (posedge clk or posedge reset or posedge set)begin
		if (reset) begin
			q <= 4'b0;
		end
		
		else if (set) begin
			q <= 4'b1111;
		end
		
		else begin
			q <= d;
		end
	end    
endmodule


// Flip Flop de 1 entradas 
module flip_flop_1(input wire clk, reset,
				 input wire d, 
				 output reg q);	
	always @ (posedge clk or posedge reset)begin
		if (reset) begin
			q <= 1'b0;
		end
		
		else begin
			q <= d;
		end
	end    
endmodule

module ejericio1(input wire A, B, clk, reset, 
				 output wire Y);	
	wire d1, d0, q1, q0;
	
	assign d0 = ~q0 & ~q1 & A;
	assign d1 = (q0 & B) | (q1 & A & B);
	
	assign Y = q1 & A & B; 
	
	flip_flop_1 F1(clk, reset, d1, q1);
	flip_flop_1 F0(clk, reset, d0, q0);
		
endmodule

module ejericio2(input wire A, clk, reset, 
				 output wire Y2, Y1, Y0);	
	wire d2, d1, d0, q2, q1, q0;
		
	assign d0 = ~q0;
	assign d1 = (~q1 & q0 & A) | (q1 & ~q0 & A) | (q1 & q0 & ~A) | (~q1 & ~q0 & ~A);
	assign d2 = (~q2 & q1 & q0 & A) | (~q2 & ~q1 & ~q0 & ~A) | (q2 & ~q1 & q0) | (q2 & ~q0 & A) | (q2 & q1 & ~A);
		
	flip_flop_1 F2(clk, reset, d2, q2);
	flip_flop_1 F1(clk, reset, d1, q1);
	flip_flop_1 F0(clk, reset, d0, q0);
	
	assign Y0 = q1 ^ q0; //(q1 & ~q0) + (~q1 & q0)
	assign Y1 = q1 ^ q2;
	assign Y2 = q2;	
	
	
endmodule