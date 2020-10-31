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

// Flip Flop JK
module flip_flop_JK(input wire clk, reset, enable, j, k,
				 output wire q);
  wire d;
	wire notK, notQ, and1, and2;
  // Not's
  not (notK, k);
	not (notQ, q);
	// And's
  and (and1, notK, q);
	and (and2, j, notQ);
  // Or's
  or  (d, and1, and2);
	flip_flop_1 F1(clk, reset, enable, d, q);
endmodule
