module testbench();
  //Variables de entrada
  reg clock, reset;
  reg [3:0]pushbuttons;

  //Variables de salida
  wire phase, c_flag, z_flag;
  wire [3:0]instr, oprnd, data_bus, FF_out, accu;
  wire [7:0]program_byte;
  wire [11:0]pc, address_ram;
  //Instanciaciones
  uP MicroProcessor(clock, reset, pushbuttons, phase, c_flag, z_flag, instr, oprnd, data_bus, FF_out, accu, program_byte, pc, address_ram);

  always
    #5 clock <=~clock;

    //Ejercicio 1
    initial begin
    #2
    $display(" \nNibbler ");
    $display("clock reset pushbuttons |  phase  c_flag   z_flag   instr   oprnd   data_bus  FF_out   Accu   program_byte       PC          address_ram ");
    $display("------------------------|----------------------------------------------------------------------------------------------------------------");
    $monitor("%b       %b       %b    |   %b       %b        %b      %b    %b     %b      %b    %b     %b     %b    %b ", clock, reset, pushbuttons, phase, c_flag, z_flag, instr, oprnd, data_bus, FF_out, accu, program_byte, pc, address_ram);

      reset = 1; clock = 0; pushbuttons = 4'b0;
  #1  reset = 0; pushbuttons = 4'b1010;
    end

    initial
      #640 $finish;
    initial begin
        $dumpfile("uP_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
