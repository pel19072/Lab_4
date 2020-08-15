// Esto es para aquellos que están usando iverilog de compilador
// Para los que usan apio pueden obviarlo
`include "code.v"
// ` -> backtick
// ' -> comilla simple


module testbench();

  // Inputs
  reg A, B, C;
  // Ground y Voltaje
  wire GRND, VCC;
  
  assign GRND = 0;
  assign VCC = 1;
  
  // Outputs para Tabla 1
  wire  led1, led2, led3;
  
  // Outputs para Tabla 2
  wire  led4, led5, led6;

  tabla_1_2   T000(A, B, C, led1);
  tabla_1_4   T001(A, B, C, led2);
  tabla_1_8   T010(GRND, VCC, A, B, C, led3);
  
  tabla_2_2   T011(A, B, C, led4);
  tabla_2_4   T100(GRND, A, B, C, led5);
  tabla_2_8   T101(GRND, VCC, A, B, C, led6);
    
  // Gate Level Modelling --> Ejercicio 1: Tablas 1 y 2 
  initial begin
	#1
    $display("Tabla 1: usando mux 2:1 | usando mux 4:1 | usando mux 8:1");
    $display("A B C | Y1 Y2 Y3");
    $display("------|---------");
    $monitor("%b %b %b | %b  %b  %b", A, B, C, led1, led2, led3);
       A = 0; B = 0; C = 0;
    #1 A = 0; B = 0; C = 1;
    #1 A = 0; B = 1; C = 0;
    #1 A = 0; B = 1; C = 1;
    #1 A = 1; B = 0; C = 0;
    #1 A = 1; B = 0; C = 1;
    #1 A = 1; B = 1; C = 0;
    #1 A = 1; B = 1; C = 1;
  end
  
  initial begin
	#10
    $display("Tabla 2: usando mux 2:1 | usando mux 4:1 | usando mux 8:1");
    $display("A B C | Y1 Y2 Y3");
    $display("------|---------");
    $monitor("%b %b %b | %b  %b  %b", A, B, C, led4, led5, led6);
       A = 0; B = 0; C = 0;
    #1 A = 0; B = 0; C = 1;
    #1 A = 0; B = 1; C = 0;
    #1 A = 0; B = 1; C = 1;
    #1 A = 1; B = 0; C = 0;
    #1 A = 1; B = 0; C = 1;
    #1 A = 1; B = 1; C = 0;
    #1 A = 1; B = 1; C = 1;
  end
  
  initial
    #19 $finish;
  
  initial begin
    $dumpfile("Test_Bench_tb.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule