module testbench();
  //Variables de entrada
  reg clock, enable, reset;

  //Variables de salida
  wire qt;

  //Instanciaciones
  flip_flop_T FT(clock, reset, enable, qt);

  always
    #1 clock <=~clock;

// Ejercicio 2
    initial begin
    #2
    $display(" \nToggle Flip Flop ");
    $display("clock reset enable |   Q ");
    $display("-------------------|--------");
    $monitor("   %b       %b      %b   |   %b", clock, reset, enable, qt);

      enable = 0; reset = 0; clock = 0;
  #2  enable = 0; reset = 1;
  #2  enable = 1; reset = 0;
  #4  enable = 0; reset = 0;
  #2  enable = 1; reset = 0;
    end

    initial
      #10 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
