//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 30/Octubre/2020
// -----------------------------------

// Ejercicio 5
// Código para Microcode
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
