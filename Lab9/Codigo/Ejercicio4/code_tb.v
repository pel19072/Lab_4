module testbench();
  //Variables de entrada
  reg enable;
  reg [3:0]in; //tris

  //Variables de salida
  wire [3:0]out; //tris

  //Instanciaciones
  tris TR(enable, in, out);

    // Ejercicio 4
    initial begin
    #1
    $display(" \nBuffer Tri-estado");
    $display("enable   IN  |  OUT ");
    $display("-------------|------");
    $monitor("%b       %b | %b", enable, in, out);

        enable = 0; in = 4'b0;
    #2  enable = 0; in = 4'b1111;
    #2  enable = 1; in = 4'b1111;
    #2  enable = 1; in = 4'b1001;
    end

    initial
      #8 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
