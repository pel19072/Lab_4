module testbench();
//Variables de cafetera
wire [1:0]M;
wire [3:0]LCD;
reg PushS, PushC;
reg clock, reset;

Cafetera  Caf1(clock, reset, PushS, PushC, M, LCD);

always
  #1 clock <=~clock;

  initial begin
  #2
  $display(" CAFETERA ");
  $display("clock PushS PushC | Motores     LCD  ");
  $display("------------------|------------------");
  $monitor("%b       %b     %b   |   %b        %b  " ,clock, PushS, PushC, M, LCD);
  end
  initial begin
    PushS = 0; PushC = 0; reset = 0; clock = 0;
#2  PushS = 0; PushC = 0; reset = 1;
#2  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#6  PushS = 0; PushC = 1; reset = 0;
#8  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#8  PushS = 1; PushC = 0; reset = 0;
#4  PushS = 0; PushC = 0; reset = 0;
#6  PushS = 0; PushC = 1; reset = 0;
#2  PushS = 0; PushC = 0; reset = 0;
#16  PushS = 0; PushC = 1; reset = 0;
#2  PushS = 0; PushC = 0; reset = 0;
#34  PushS = 0; PushC = 1; reset = 0;
#2  PushS = 0; PushC = 0; reset = 0;

  end

  initial
    #190 $finish;
  initial begin
      $dumpfile("FSM_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule
