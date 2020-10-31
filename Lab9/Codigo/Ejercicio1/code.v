//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 30/Octubre/2020
// -----------------------------------

// Ejercicio 1
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

module flip_flop_2(input wire clk, reset, enable,
				 input wire [1:0]d,
				 output wire [1:0]q);
  flip_flop_1 F1(clk, reset, enable, d[0], q[0]);
  flip_flop_1 F2(clk, reset, enable, d[1], q[1]);
endmodule

module flip_flop_4(input wire clk, reset, enable,
				 input wire [3:0]d,
				 output wire [3:0]q);
  flip_flop_1 F1(clk, reset, enable, d[0], q[0]);
  flip_flop_1 F2(clk, reset, enable, d[1], q[1]);
  flip_flop_1 F3(clk, reset, enable, d[2], q[2]);
  flip_flop_1 F4(clk, reset, enable, d[3], q[3]);
endmodule
