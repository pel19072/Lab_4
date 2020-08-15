//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 14/Agosto/2020
// Uso de multiplexores
// -----------------------------------


// Mux 2:1
module mux_2(input wire A, B, C, output wire Y);

  assign Y = A?C:B;

endmodule

// Mux 4:1
module mux_4(input wire A, B, C, D, 
			 input wire[1:0] S, 
			 output wire Y);

  wire Y1, Y2;
  
  mux_2	m1(S[0], A, B, Y1);
  mux_2 m2(S[0], C, D, Y2);
  mux_2 m3(S[1], Y1, Y2, Y);

endmodule

// Mux 8:1
module mux_8(input wire A, B, C, D, E, F, G, H, 
			 input wire[2:0] S, 
			 output wire Y);
  
  wire Y1, Y2;
  
  mux_4	m1(A, B, C, D, S[1:0], Y1);
  mux_4 m2(E, F, G, H, S[1:0], Y2);
  mux_2 m3(S[2], Y1, Y2, Y);

endmodule

// Tabla 1 usando mux_2
module tabla_1_2(input wire A, B, C, 
				 output wire Y);
  
  wire Y1, Y2;
  
  assign Y1 = (B ^ C); // Primera entrada del mux_2
  assign Y2 = ~(B ^ C);  // Segunda entrada del mux_2
  
  mux_2 T(A, Y1, Y2, Y);

endmodule

// Tabla 1 usando mux_4
module tabla_1_4(input wire A, B, C, 
				 output wire Y);
  
  wire Y1;
  wire [1:0] Y2;
  
  assign Y1 = ~C; 
  assign Y2[0] = B;
  assign Y2[1] = A;
  
  mux_4 T(C, Y1, Y1, C, Y2[1:0], Y);

endmodule

// Tabla 1 usando mux_8
module tabla_1_8(input wire GRND, VCC, A, B, C,
				 output wire Y);

   wire [2:0] Y1;
   
   assign Y1[0] = C;
   assign Y1[1] = B;
   assign Y1[2] = A;
   
   mux_8 T(GRND, VCC, VCC, GRND, VCC, GRND, GRND, VCC, Y1[2:0], Y);
		
endmodule

// Tabla 2 usando mux_2
module tabla_2_2(input wire A, B, C, 
				 output wire Y);
  
  wire Y1, Y2;
  
  assign Y1 = ~(B | C); // Primera entrada del mux_2
  assign Y2 = (B ^ C);  // Segunda entrada del mux_2
  
  mux_2 T(A, Y1, Y2, Y);

endmodule

// Tabla 2 usando mux_4
module tabla_2_4(input wire GRND, A, B, C, 
				 output wire Y);
  
  wire Y1;
  wire [1:0] Y2;
  
  assign Y1 = ~C; 
  assign Y2[0] = B;
  assign Y2[1] = A;
  
  mux_4 T(Y1, GRND, C, Y1, Y2[1:0], Y);

endmodule

// Tabla 2 usando mux_8
module tabla_2_8(input wire GRND, VCC, A, B, C,
				 output wire Y);

   wire [2:0] Y1;
   
   assign Y1[0] = C;
   assign Y1[1] = B;
   assign Y1[2] = A;
   
   mux_8 T(VCC, GRND, GRND, GRND, GRND, VCC, VCC, GRND, Y1[2:0], Y);
		
endmodule
				 
