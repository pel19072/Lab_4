module testbench();
  //Variables de entrada
  reg clock, enablef, enablec, reset, load;
  reg [11:0]load_data;

  //Variables de salida
  wire [7:0]opcode;
  wire [3:0]instruction;
  wire [3:0]operand;

  //Instanciaciones
  Program P1(clock, reset, enablec, enablef, load, load_data, opcode, instruction, operand);

  always
    #1 clock <=~clock;

    //Ejercicio 1
    initial begin
    #2
    $display(" \nPrograma ");
    $display("clock reset enablec enablef load        load_data    |    opcode    instruction   operand ");
    $display("-----------------------------------------------------|------------------------------------");
    $monitor("%b       %b     %b       %b       %b       %b   |   %b      %b        %b", clock, reset, enablec, enablef, load, load_data, opcode, instruction, operand);

      enablec = 0; enablef = 0; reset = 1; clock = 0; load = 0; load_data = 12'b0;
  #2  enablec = 0; enablef = 0; reset = 0; load = 0; load_data = 12'b0;
  #2  enablec = 1; enablef = 1; reset = 0; load = 0; load_data = 12'b0;
  #6  enablec = 1; enablef = 1; reset = 0; load = 1; load_data = 12'b0;
  #2  enablec = 1; enablef = 1; reset = 0; load = 1; load_data = 12'b000000001010;
  #2  enablec = 1; enablef = 1; reset = 0; load = 0; load_data = 12'b0;
  #2  enablec = 1; enablef = 1; reset = 0; load = 0; load_data = 12'b0;
  #2  enablec = 1; enablef = 1; reset = 0; load = 0; load_data = 12'b0;
    end

    initial
      #18 $finish;
    initial begin
        $dumpfile("Ejercicio1_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
