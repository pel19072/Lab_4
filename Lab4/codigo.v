//-----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 9/Agosto/2020
// Gate Level Modelling 
// Tablas del Ejercicio 01: Tabla 01 y Tabla 02 
// Tablas del Ejercicio 02: Tabla 02 y Tabla 04
// Operadores
// Tablas del Ejercicio 01: Tabla 03 y Tabla 04
// Tablas del Ejercicio 02: Tabla 01 y Tabla 03
// -----------------------------------

// Ejercicio 1 Tabla 1;

module gateLevel_1(input wire A, B, C, output wire Y);

  wire notA, notB, notC, or1, or2;

  // Not's 
  
  not (notA, A);
  not (notB, B);
  not (notC, C);
  
  // Or's
  
  or  (or1, A, notC);
  or  (or2, notA, notB, C);
  
  // And's
  
  and (Y, or1, or2);
  
endmodule

// Ejercicio 1 Tabla 2;

module gateLevel_2(input wire A, B, C, output wire Y);

  wire notA, notB, notC, or1, or2;

  // Not's 
  
  not (Y, B);
  
endmodule

// Ejercicio 2 Tabla 2;

module gateLevel_3(input wire A, B, C, output wire Y);

  wire notA, notB, notC, or1, or2;

  // Not's 
  
  not (notB, B);
  
  // Or's
  
  or  (Y, notB, C);
    
endmodule

// Ejercicio 2 Tabla 4;

module gateLevel_4(input wire A, B, C, output wire Y);

  wire notA, notB, notC, or1, or2;

  // Not's 
  
  not (notA, A);
  not (notC, C);
  
  // Or's
  
  or  (or1, notA, B);
  or  (or2, B, notC);
  
  // And's
  
  and (Y, or1, or2);
  
endmodule


// Ejercicio 1 Tabla 3
module operadores_1(input wire A, B, C, D, output wire Y);

  assign Y = (~A & ~B & ~C & ~D) | (~A & ~B & C & D) | (~A & B & ~C & D) | (~A & B & C & ~D) | (A & B & ~C & ~D) | (A & B & C & D) | (A & ~B & ~C & D) | (A & ~B & C & ~D);

endmodule

// Ejercicio 1 Tabla 4
module operadores_2(input wire A, B, C, D, output wire Y);

  assign Y = A & (~A | B | C | ~D);

endmodule

// Ejercicio 2 Tabla 1
module operadores_3(input wire A, B, C, D, output wire Y);

  assign Y = (~B & ~C & ~D) | (A & ~C) | (A & ~B) | (A & C & ~D);

endmodule

// Ejercicio 2 Tabla 3
module operadores_4(input wire A, B, C, D, output wire Y);

  assign Y = (B | D) & (A | B | ~C);
  
endmodule

//Ejercicio 5
// SOP utilizando Behavioral Modelling
module alarma_sop(input wire A, B, C, output wire Y);

	assign Y = (A & ~B & ~C) | (A & ~B & C) | (A & B & C);

endmodule

// POS utilizando Behavioral Modelling
module alarma_pos(input wire A, B, C, output wire Y);

	assign Y = (A | B | C) & (A | B | ~C) & (A | ~B | C) & (A | ~B | ~C) & (~A | ~B | C);

endmodule

// Simplificada con mapa de Karnaugh utilizando Gate Level Modelling
module alarma_k(input wire A, B, C, output wire Y);
	
	wire notB, or1;
	
	//Not's
	
	not (notB, B);
	
	//Or's
	
	or (or1, notB, C);
	
	//And's
	
	and (Y, A, or1);
	
endmodule