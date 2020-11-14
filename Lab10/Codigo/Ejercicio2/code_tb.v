module testbench();
  //Variables de entrada
  reg clock, reset, enablea, enablebuff1, enablebuff2;
  reg [2:0]selector;
  reg [3:0]in;

  //Variables de salida
  wire [1:0]flags;
  wire [3:0]out, accu;

  //Instanciaciones
  Program P1(clock, reset, enablea, enablebuff1, enablebuff2, selector, in, flags, out);

  always
    #1 clock <=~clock;

    //Ejercicio 1
  initial begin
    #2
    $display(" \nPrograma ");
    $display("clock reset enablea enablebuff1 enablebuff2 selector    in   | flags   out ");
    $display("-------------------------------------------------------------|-------------");
    $monitor("%b       %b      %b          %b           %b       %b      %b  |  %b    %b ", clock, reset, enablea, enablebuff1, enablebuff2, selector, in, flags, out);

      enablea = 0; enablebuff1 = 0; enablebuff2 = 0; reset = 1; clock = 0; selector = 3'b0; in = 4'b0;
    #2  enablea = 0; enablebuff1 = 0; enablebuff2 = 0; reset = 0; selector = 3'b0; in = 4'b0;
    #2  enablea = 1; enablebuff1 = 1; enablebuff2 = 1; reset = 0; selector = 3'b0; in = 4'b1010;
    #2  enablea = 1; enablebuff1 = 1; enablebuff2 = 1; reset = 0; selector = 3'b001; in = 4'b0100;
    #2  enablea = 1; enablebuff1 = 1; enablebuff2 = 1; reset = 0; selector = 3'b010; in = 4'b0001;
    #2  enablea = 1; enablebuff1 = 1; enablebuff2 = 1; reset = 0; selector = 3'b011; in = 4'b0110;
    #2  enablea = 1; enablebuff1 = 1; enablebuff2 = 1; reset = 0; selector = 3'b100; in = 4'b0111;
  end

    initial
      #16 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
