// Esto es para aquellos que están usando iverilog de compilador
// Para los que usan apio pueden obviarlo
`include "code.v"
// ` -> backtick
// ' -> comilla simple


module testbench();

  // Inputs
  reg clk, reset, set;
  reg[3:0] d;
  wire[3:0] q;
  reg A, B, push;
  wire led1;
  wire led22, led21, led20;
  
  assign led2 = 3'b0; 
  
  always 
	  begin
		clk <= 0; #1 clk <= 1; #1; 
	  end
  
  flip_flop F1(clk, reset, set, d, q);
  ejericio1 E1(A, B, clk, reset, led1);
  ejericio2 E2(push, clk, reset, led22, led21, led20);
  
  
  always 
	  begin
		set <= 0; #1 set <= ~set; #3; 
	  end
	  
  
  initial begin
	#6
    $display("Flip Flop D - Reset Asincrono - Set Sincrono");
    $display("CLK SET  RESET     D    |   Q  ");
    $display("------------------------|------");
    $monitor(" %b    %b    %b     %b   | %b ", clk, set, reset, d, q);
		d[0] = 0; d[1] = 0; d[2] = 0; d[3] = 1; reset = 0;
	#1	d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 0; reset = 0;
	#1	d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; reset = 0;
	#1	d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 1; reset = 0;
	#1	d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; reset = 1;
	#1	d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; reset = 0;
	#1	d[0] = 0; d[1] = 0; d[2] = 1; d[3] = 0; reset = 0;
	#1	d[0] = 0; d[1] = 1; d[2] = 0; d[3] = 1; reset = 0;
	#1	d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 1; reset = 0;
	#1	d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; reset = 1;
	#1	d[0] = 1; d[1] = 1; d[2] = 1; d[3] = 0; reset = 0;
	#1	d[0] = 0; d[1] = 1; d[2] = 1; d[3] = 1; reset = 1;
	#1	d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; reset = 0;
	#1	d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 0; reset = 0;
	#1	d[0] = 1; d[1] = 1; d[2] = 0; d[3] = 1; reset = 0;
	#1	d[0] = 1; d[1] = 0; d[2] = 0; d[3] = 0; reset = 0;
	end
  
  initial begin
  #22
    $display("Ejercicio 1");
    $display("A B | Y");
    $display("----|---");
    $monitor("%b %b | %b ", A, B, led1);
		A = 0; B = 0; 
	#2	A = 0; B = 1;
	#2	A = 1; B = 0;
	#2	A = 1; B = 1;
	#2	A = 0; B = 1;
	#2	A = 0; B = 0; 
	#2	A = 0; B = 1;
	#2	A = 1; B = 0;
	#2	A = 1; B = 1;
	#2	A = 0; B = 1;
	
	end
  
  initial begin
	#41
    $display("Ejercicio 3");
    $display(" Push |  Y2 Y1 Y0");
    $display("------|----------");
    $monitor("   %b  |  %b  %b  %b", push, led22, led21, led20);
		push = 0; reset = 1;
	#2	push = 0; reset = 0;
	#2  push = 0;
	#2  push = 0;
	#2  push = 0;
	#2  push = 0;
	#2  push = 0;
	#2  push = 0;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	#2  push = 1;
	
	end
  
  initial
    #73 $finish;
  
  initial begin
    $dumpfile("test_tb.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule