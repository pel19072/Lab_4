// Buffer Tri-estado --> Funciona
module Tris (input wire enable, input wire [3:0]in, output wire [3:0]out);
  assign out = enable ? in:4'bz;
endmodule

// Flip Flop Tipo D
module Accumulator (input wire clk, reset, enable, input wire [3:0]result, output reg [3:0]accu);
	always @ (posedge clk or posedge reset or enable) begin
		if (reset) begin
			accu <= 4'b0;
		end
    else if (enable) begin
      accu <= result;
    end
	end
endmodule

//ALU - Los 3 bits de seleccion vienen del microcode el databus es el operand y la accu es W
module ALU (input wire [3:0]data_bus, accu, input wire [2:0]selector, output wire [3:0]result, output wire [1:0]flags);
  wire zero, carry;
  reg [4:0]result_flags;
  always @ ( * ) begin
    case (selector)
    0:
      result_flags <= accu;
    1:
      result_flags <= accu - data_bus;
    2:
      result_flags <= data_bus;
    3:
      result_flags <= accu + data_bus;
    4:
      result_flags <= accu ~& data_bus;
    default:
      result_flags <= 5'b0;
    endcase
  end
  assign result = result_flags[3:0];
  assign carry = result_flags[4];
  assign zero = (result_flags == 5'b0) ? 1'b1:1'b0;
  assign flags[0] = zero;
  assign flags[1] = carry;
endmodule

module Program (input wire clk, reset, enablea, enablebuff1, enablebuff2, input wire [2:0]selector, input wire [3:0]in1, output wire [1:0]flags, output wire [3:0]out2);
  wire [3:0]data_bus, result, accu;
  Tris Buff1(enablebuff1, in1, data_bus);
  Accumulator W1(clk, reset, enablea, result, accu);
  ALU A1(data_bus, accu, selector, result, flags);
  Tris Buff2(enablebuff2, result, out2);
endmodule
