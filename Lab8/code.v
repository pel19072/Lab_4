//Counter - No sé si funciona
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

module ROM_Memory (input wire [11:0]address, output wire [7:0]opcode);
  reg [7:0] ROM [0:4095];
  initial begin
      $readmemh("ejemplo.list", ROM);
  end
  assign opcode = ROM[address];
endmodule

module ALU (input wire [3:0]A, input wire [3:0]B, input wire [2:0]selector, output reg [3:0]result);
  always @ ( * ) begin
    case (selector)
    0:
      result <= A & B;
    1:
      result <= A | B;
    2:
      result <= A + B;
    3:
      result <= 4'b0;
    4:
      result <= A & ~B;
    5:
      result <= A | ~B;
    6:
      result <= A - B;
    7:
      result <= (A < B) ? 4'b1111:4'b0;
    default:
      result <= 4'b0;
    endcase
  end
endmodule
