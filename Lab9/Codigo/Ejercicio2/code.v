//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 30/Octubre/2020
// -----------------------------------

// Flip Flop Tipo D
module flip_flop_1(input wire clk, reset, enable,
				 input wire d,
				 output reg q);
	always @ (posedge clk or posedge reset or enable)begin
		if (reset) begin
			q <= 1'b0;
		end
    else if (enable) begin
      q <= d;
    end
	end
endmodule

// Flip Flop Toggle
module flip_flop_T(input wire clk, reset, enable,
				 output wire q);
  wire d;
  assign d = ~q;
	flip_flop_1 F1(clk, reset, enable, d, q);
endmodule
