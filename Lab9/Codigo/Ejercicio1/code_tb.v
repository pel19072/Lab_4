module testbench();
  //Variables de entrada
  reg clock, enable, reset, d1;
  reg [1:0]d2; //flip flop 2 bit
  reg [3:0]d4; //flip flop 4 bit

  //Variables de salida
  wire q1;
  wire [1:0]q2; //flip flop 2 bit
  wire [3:0]q4; //flip flop 4 bit

  //Instanciaciones
  flip_flop_1 F1(clock, reset, enable, d1, q1);
  flip_flop_2 F2(clock, reset, enable, d2, q2);
  flip_flop_4 F3(clock, reset, enable, d4, q4);

  always
    #1 clock <=~clock;

    //Ejercicio 1
    initial begin
    #2
    $display(" \nFlip Flops Tipo D ");
    $display(" \nUn Bit ");
    $display("clock reset enable    D   |   Q ");
    $display("--------------------------|--------");
    $monitor("%b       %b     %b       %b   |   %b", clock, reset, enable, d1, q1);

      enable = 0; reset = 0; d1 = 0; clock = 0;
  #2  enable = 0; reset = 1; d1 = 0;
  #2  enable = 1; reset = 0; d1 = 0;
  #2  enable = 1; reset = 0; d1 = 1;
  #2  enable = 1; reset = 0; d1 = 0;
  #2
    $display(" \nDos Bits ");
    $display("clock reset enable  D  |   Q ");
    $display("-----------------------|--------");
    $monitor("%b       %b      %b    %b |   %b", clock, reset, enable, d2, q2);

      enable = 0; reset = 0; d2 = 2'b0;
  #2  enable = 1; reset = 0; d2 = 2'b10;
  #2  enable = 1; reset = 0; d2 = 2'b01;
  #2  enable = 1; reset = 0; d2 = 2'b11;
  #2
    $display(" \nCuatro Bits ");
    $display("clock reset enable     D  |   Q ");
    $display("--------------------------|--------");
    $monitor("%b       %b      %b     %b |  %b", clock, reset, enable, d4, q4);

      enable = 0; reset = 0; d4 = 4'b0;
  #2  enable = 1; reset = 0; d4 = 4'b1000;
  #2  enable = 1; reset = 0; d4 = 4'b0101;
  #2  enable = 1; reset = 0; d4 = 4'b1100;
    end

    initial
      #28 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
