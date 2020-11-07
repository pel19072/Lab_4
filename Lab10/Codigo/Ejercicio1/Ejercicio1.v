//Counter - Sí funciona
module Counter (input wire clock, reset, load, enable, input wire [11:0]load_data, output reg [11:0]value);
  always @ (posedge clock, posedge reset, load, load_data) begin
    if (reset) begin
      value <= 12'b0;
    end
    else if (load) begin
      value <= load_data;
    end
    else if (enable) begin
      if (value < 12'b111111111111) begin
        value <= value + 1;
      end
    end
  end
endmodule

//ROM - Sí funciona
module ROM_Memory (input wire [11:0]address, output wire [7:0]opcode);
  reg [7:0] ROM [0:4095];
  initial begin
      $readmemh("ejemplo.list", ROM);
  end
  assign opcode = ROM[address];
endmodule

// Flip Flop Tipo D
module flip_flop (input wire clk, reset, enable, input wire [7:0]d, output reg [7:0]q);
	always @ (posedge clk or posedge reset or enable)begin
		if (reset) begin
			q <= 8'b0;
		end
    else if (enable) begin
      q <= d;
    end
	end
endmodule

//Fetch
module Fetch (input wire clk, reset, enable, input wire [7:0]opcode, output wire [3:0]instruction, operand);
  wire [7:0]q;
  assign instruction = q[7:4];
  assign operand = q[3:0];
  flip_flop F1(clk, reset, enable, opcode, q);
endmodule

//Union de Modulos
module Program (input wire clk, reset, enablec, enablef, load, input wire [11:0]load_data, output wire [7:0]opcode, output wire [3:0]instruction, operand);
  wire [11:0]address;
  Counter C1(clk, reset, load, enablec, load_data, address);
  ROM_Memory R1(address, opcode);
  Fetch F1(clk, reset, enablef, opcode, instruction, operand);
endmodule
