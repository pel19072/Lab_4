module testbench();
  //Variables de entrada
  reg clock, enable, reset, j, k;

  //Variables de salida
  wire qjk;

  //Instanciaciones
  flip_flop_JK FJK(clock, reset, enable, j, k, qjk);

  always
    #1 clock <=~clock;

    // Ejercicio 3
    initial begin
    #2
    $display(" \nFlip Flop JK");
    $display("clock reset enable J   K |   Q ");
    $display("-------------------------|--------");
    $monitor("%b       %b     %b    %b   %b |   %b", clock, reset, enable, j, k, qjk);

        enable = 0; reset = 1; j = 0; k = 0; clock = 0;
    #2  enable = 1; reset = 0; j = 0; k = 0;
    #2  enable = 1; reset = 0; j = 0; k = 1;
    #2  enable = 1; reset = 0; j = 1; k = 0;
    #2  enable = 1; reset = 0; j = 1; k = 1;
    #2  enable = 0; reset = 0; j = 1; k = 0;
    end

    initial
      #14 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
