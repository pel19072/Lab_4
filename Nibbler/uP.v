//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 22/Noviembre/2020
// -----------------------------------

//Program Counter - Sí funciona
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
      $readmemh("codigo.list", ROM);
  end
  assign opcode = ROM[address];
endmodule

// Flip Flop Tipo D --> para fetch
module flip_flop8 (input wire clk, reset, enable, input wire [7:0]d, output reg [7:0]q);
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
  flip_flop8 F1(clk, reset, enable, opcode, q);
endmodule

// Flip Flop Tipo D --> para flags
module Flags (input wire clk, reset, enable, input wire [1:0]d, output reg [1:0]q);
	always @ (posedge clk or posedge reset or enable)begin
		if (reset) begin
			q <= 2'b0;
		end
    else if (enable) begin
      q <= d;
    end
	end
endmodule

// Flip Flop Tipo D --> para toggle del phase
module flip_flop1 (input wire clk, reset, enable, input wire d, output reg q);
	always @ (posedge clk or posedge reset or enable)begin
		if (reset) begin
			q <= 1'b0;
		end
    else if (enable) begin
      q <= d;
    end
	end
endmodule

// Flip Flop Toggle --> para phase
module Phase (input wire clk, reset, enable, output wire q);
  wire d;
  assign d = ~q;
	flip_flop1 F1(clk, reset, enable, d, q);
endmodule

//Decode
module Microcode(input wire [6:0]address, output reg [12:0]control);
  always @ ( * ) begin
    casex (address)
    7'bxxxxxx0: //0
      control <= 13'b1000000001000;
    7'b00001x1: //1
      control <= 13'b0100000001000;
    7'b00000x1: //2
      control <= 13'b1000000001000;
    7'b00011x1: //3
      control <= 13'b1000000001000;
    7'b00010x1: //4
      control <= 13'b0100000001000;
    7'b0010xx1: //5
      control <= 13'b0001001000010;
    7'b0011xx1: //6
      control <= 13'b1001001100000;
    7'b0100xx1: //7
      control <= 13'b0011010000010;
    7'b0101xx1: //8
      control <= 13'b0011010000100;
    7'b0110xx1: //9
      control <= 13'b1011010100000;
    7'b0111xx1: //10
      control <= 13'b1000000111000;
    7'b1000x11: //11
      control <= 13'b0100000001000;
    7'b1000x01: //12
      control <= 13'b1000000001000;
    7'b1001x11: //13
      control <= 13'b1000000001000;
    7'b1001x01: //14
      control <= 13'b0100000001000;
    7'b1010xx1: //15
      control <= 13'b0011011000010;
    7'b1011xx1: //16
      control <= 13'b1011011100000;
    7'b1100xx1: //17
      control <= 13'b0100000001000;
    7'b1101xx1: //18
      control <= 13'b0000000001001;
    7'b1110xx1: //19
      control <= 13'b0011100000010;
    7'b1111xx1: //20
      control <= 13'b1011100100000;
    default:
      control <= 13'b0;
    endcase
  end
endmodule

// Buffer Tri-estado --> Funciona
module Tris (input wire enable, input wire [3:0]in, output wire [3:0]out);
  assign out = enable ? in:4'bz;
endmodule

//RAM
module RAM_Memory (input wire enable, write, read, input wire [11:0]address_RAM, inout data);
  reg [3:0] RAM [0:4095];
  reg [3:0]data_out;

  //Coloca un tris para poder escribir o leer
  assign data = (enable & read & ~write) ? data_out:8'bz;
  //Bloque de escritura
  always @ ( address_RAM or data or enable or write ) begin
    if (enable && write) begin
      RAM[address_RAM] = data;
    end
  end
  //Bloque de lectura
  always @ ( address_RAM or enable or write or read) begin
    if (enable && ~write && read) begin
      data_out = RAM[address_RAM];
    end
  end
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

// Flip Flop Tipo D --> para outputs
module Outputs (input wire clk, reset, enable, input wire [3:0]d, output reg [3:0]q);
	always @ (posedge clk or posedge reset or enable)begin
		if (reset) begin
			q <= 4'b0;
		end
    else if (enable) begin
      q <= d;
    end
	end
endmodule

//Nibbler
module uP (input wire clock, reset, input wire [3:0]pushbuttons, output wire phase, c_flag, z_flag, output wire [3:0]instr, oprnd, data_bus, FF_out, accu, output wire [7:0]program_byte, output wire [11:0]pc, address_ram);
  wire carry, zero;
  wire [12:0]control;
  wire [3:0]alu_result;
  wire [6:0]address;
  assign instr = address[6:3];
  assign c_flag = address[2];
  assign z_flag = address[1];
  assign phase = address[0];
  Microcode M1(address, control);
  Counter PC1(clock, reset, control[5], control[6], address_ram, pc);
  ROM_Memory ROM1(pc, program_byte);
  Fetch FE1(clock, reset, enable, program_byte, instr, oprnd); //Enable del fetch???
endmodule
