// Esto es para aquellos que están usando iverilog de compilador
// Para los que usan apio pueden obviarlo
`include "codigo.v"
// ` -> backtick
// ' -> comilla simple


module testbench();

  // Inputs para Gate_Level
  reg p1, p2, p3, p4, p5, p6;
  // Inputs para Operators
  reg i1, i2, i3, i4, i5, i6, i7, i8;
  // Inputs para ejercicio 5
  reg a1, a2, a3;
  
  // Outputs para Gate_Level
  wire led1, led2, led3, led4;
  // Outputs para Operators
  wire led5, led6, led7, led8;
  // Outputs para ejercicio 5
  wire led9, led10, led11;

  gateLevel_1   G1(p1, p2, p3, led1);
  gateLevel_2   G2(p1, p2, p3, led2);
  gateLevel_3   G3(p4, p5, p6, led3);
  gateLevel_4   G4(p4, p5, p6, led4);
  
  
  operadores_1 OP1(i1, i2, i3, i4, led5);
  operadores_2 OP2(i1, i2, i3, i4, led6);
  operadores_3 OP3(i5, i6, i7, i8, led7);
  operadores_4 OP4(i5, i6, i7, i8, led8);
  
  alarma_sop	AL1(a1, a2, a3, led9);
  alarma_pos	AL2(a1, a2, a3, led10);
  alarma_k		AL3(a1, a2, a3, led11);

  
  // Gate Level Modelling --> Ejercicio 1: Tablas 1 y 2 
  initial begin
	#1
    $display("Ejercicio 1: Tablas 1 y 2");
    $display("A B C | Y1 Y2");
    $display("------|------");
    $monitor("%b %b %b | %b  %b", p1, p2, p3, led1, led2);
       p1 = 0; p2 = 0; p3 = 0;
    #1 p1 = 0; p2 = 0; p3 = 1;
    #1 p1 = 0; p2 = 1; p3 = 0;
    #1 p1 = 0; p2 = 1; p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p1 = 1; p2 = 0; p3 = 1;
    #1 p1 = 1; p2 = 1; p3 = 0;
    #1 p1 = 1; p2 = 1; p3 = 1;
  end
  
  // Gate Level Modelling --> Ejercicio 2: Tablas 2 y 4
  initial begin
    #10
    $display("\n");
	$display("Ejercicio 2: Tablas 2 y 4");
    $display("A B C | Y1 Y2");
    $display("------|------");
    $monitor("%b %b %b | %b %b", p4, p5, p6, led3, led4);
       p4 = 0; p5 = 0; p6 = 0;
    #1 p4 = 0; p5 = 0; p6 = 1;
    #1 p4 = 0; p5 = 1; p6 = 0;
    #1 p4 = 0; p5 = 1; p6 = 1;
    #1 p4 = 1; p5 = 0; p6 = 0;
    #1 p4 = 1; p5 = 0; p6 = 1;
    #1 p4 = 1; p5 = 1; p6 = 0;
    #1 p4 = 1; p5 = 1; p6 = 1;
  end
  
  // Operators --> Ejercicio 1: Tablas 3 y 4
  initial begin
	#18
	$display("\n");
    $display("Ejercicio 1: Tablas 3 y 4");
    $display("A B C D | Y1 Y2");
    $display("--------|------");
    $monitor("%b %b %b %b | %b  %b", i1, i2, i3, i4, led5, led6);
       i1 = 0; i2 = 0; i3 = 0; i4 = 0;
    #1 i1 = 0; i2 = 0; i3 = 0; i4 = 1;
    #1 i1 = 0; i2 = 0; i3 = 1; i4 = 0;
    #1 i1 = 0; i2 = 0; i3 = 1; i4 = 1;
    #1 i1 = 0; i2 = 1; i3 = 0; i4 = 0;
    #1 i1 = 0; i2 = 1; i3 = 0; i4 = 1;
    #1 i1 = 0; i2 = 1; i3 = 1; i4 = 0;
    #1 i1 = 0; i2 = 1; i3 = 1; i4 = 1;
	#1 i1 = 1; i2 = 0; i3 = 0; i4 = 0;
    #1 i1 = 1; i2 = 0; i3 = 0; i4 = 1;
    #1 i1 = 1; i2 = 0; i3 = 1; i4 = 0;
    #1 i1 = 1; i2 = 0; i3 = 1; i4 = 1;
    #1 i1 = 1; i2 = 1; i3 = 0; i4 = 0;
    #1 i1 = 1; i2 = 1; i3 = 0; i4 = 1;
    #1 i1 = 1; i2 = 1; i3 = 1; i4 = 0;
    #1 i1 = 1; i2 = 1; i3 = 1; i4 = 1;
  end
  
  // Gate Level Modelling --> Ejercicio 2: Tablas 2 y 4
  initial begin
    #35
    $display("\n");
	$display("Ejercicio 2: Tablas 1 y 3");
    $display("A B C D | Y1 Y2");
    $display("--------|------");
    $monitor("%b %b %b %b | %b  %b", i5, i6, i7, i8, led7, led8);
       i5 = 0; i6 = 0; i7 = 0; i8 = 0;
    #1 i5 = 0; i6 = 0; i7 = 0; i8 = 1;
    #1 i5 = 0; i6 = 0; i7 = 1; i8 = 0;
    #1 i5 = 0; i6 = 0; i7 = 1; i8 = 1;
    #1 i5 = 0; i6 = 1; i7 = 0; i8 = 0;
    #1 i5 = 0; i6 = 1; i7 = 0; i8 = 1;
    #1 i5 = 0; i6 = 1; i7 = 1; i8 = 0;
    #1 i5 = 0; i6 = 1; i7 = 1; i8 = 1;
	#1 i5 = 1; i6 = 0; i7 = 0; i8 = 0;
    #1 i5 = 1; i6 = 0; i7 = 0; i8 = 1;
    #1 i5 = 1; i6 = 0; i7 = 1; i8 = 0;
    #1 i5 = 1; i6 = 0; i7 = 1; i8 = 1;
    #1 i5 = 1; i6 = 1; i7 = 0; i8 = 0;
    #1 i5 = 1; i6 = 1; i7 = 0; i8 = 1;
    #1 i5 = 1; i6 = 1; i7 = 1; i8 = 0;
    #1 i5 = 1; i6 = 1; i7 = 1; i8 = 1;
  end
  
  initial begin
    #52
    $display("\n");
	$display("Ejercicio 5: SOP | POS | Karnaugh");
    $display("A B C | Y1 Y2 Y3");
    $display("------|---------");
    $monitor("%b %b %b | %b  %b  %b", a1, a2, a3, led9, led10, led11);
       a1 = 0; a2 = 0; a3 = 0;
    #1 a1 = 0; a2 = 0; a3 = 1;
    #1 a1 = 0; a2 = 1; a3 = 0;
    #1 a1 = 0; a2 = 1; a3 = 1;
    #1 a1 = 1; a2 = 0; a3 = 0;
    #1 a1 = 1; a2 = 0; a3 = 1;
    #1 a1 = 1; a2 = 1; a3 = 0;
    #1 a1 = 1; a2 = 1; a3 = 1;
  end  
  
  initial
    #60 $finish;
  
  initial begin
    $dumpfile("Test_Bench_tb.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule