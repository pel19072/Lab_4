//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 30/Octubre/2020
// -----------------------------------

// Buffer Tri-estado --> Funciona
module tris(input wire enable, input wire [3:0]in,
				 output wire [3:0]out);
  assign out = enable ? in:4'bz;
endmodule
