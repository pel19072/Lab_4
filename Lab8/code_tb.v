module testbench();
//Variables de cafetera
wire [11:0]value;
wire [7:0]opcode;
wire [3:0]R;
reg clock, reset, load, enable;
reg [11:0]address;
reg [11:0]load_data;
reg [3:0]A;
reg [3:0]B;
reg [2:0]S;

Counter  C1(clock, reset, load, enable, load_data, value);
ROM_Memory R1(address, opcode);
ALU Al(A, B, S, R);

always
  #1 clock <=~clock;

  initial begin
  #2
  $display(" \nCONTADOR ");
  $display("clock reset load enable   load_data    | value  ");
  $display("---------------------------------------|--------");
  $monitor("%b     %b     %b     %b     %b   |   %b", clock, reset, load, enable, load_data, value);
  end
  initial begin
    load = 0; enable = 0; reset = 0; load_data = 12'b0; clock = 0;
#2  load = 0; enable = 0; reset = 1; load_data = 12'b0;
#2  load = 0; enable = 1; reset = 0; load_data = 12'b0;
#4  load = 0; enable = 1; reset = 0; load_data = 12'b0;
#4  load = 0; enable = 1; reset = 0; load_data = 12'b0;
#4  load = 1; enable = 1; reset = 0; load_data = 12'b010101010101;
#4  load = 1; enable = 1; reset = 0; load_data = 12'b010111110101;
#4  load = 0; enable = 1; reset = 0; load_data = 12'b0;

  end

  initial begin
  #28
  $display(" \nMEMORIA ROM ");
  $display("address       |    opcode   ");
  $display("--------------|-------------");
  $monitor("%b  |   %b", address, opcode);

      address = 12'b0;
  #2  address = 12'b000000000001;
  #2  address = 12'b000000000011;

  end

  initial begin
  #40
  $display(" \nALU ");
  $display(" Primera Prueba ");
  $display("A       B    Selector |  Resultado  ");
  $display("----------------------|-------------");
  $monitor("%b   %b     %b   |   %b", A, B, S, R);

      A = 4'b1010; B = 4'b0101; S = 3'b0;
  #4  S = 3'b001;
  #4  S = 3'b010;
  #4  S = 3'b011;
  #4  S = 3'b100;
  #4  S = 3'b101;
  #4  S = 3'b110;
  #4  S = 3'b111;

  #4
  $display(" \nSegunda Prueba ");

  #4  A = 4'b0110; B = 4'b1100; S = 3'b0;
  #4  S = 3'b001;
  #4  S = 3'b010;
  #4  S = 3'b011;
  #4  S = 3'b100;
  #4  S = 3'b101;
  #4  S = 3'b110;
  #4  S = 3'b111;

  end

  initial
    #108 $finish;
  initial begin
      $dumpfile("code_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule
