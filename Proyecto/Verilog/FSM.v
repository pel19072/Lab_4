//Ricardo Pellecer Orellana - Carné 19072
//Proyecto Finite State Machines
//En este documento se encuentra la creación de cada máquina de estados finitos como una caja negra y la creación de los flip flops tipo D
//Fecha: 4/Octubre/2020

//Flip flop tipo D de 4 entradas - Sí funciona
module FF4 (input wire clock, reset, input wire [3:0]D, output reg [3:0]Q);
always @ (posedge clock, posedge reset) begin
  if (reset) begin
    Q <= 4'b0;
    end
  else begin
    Q <= D;
    end
    end
endmodule

//Flip flop tipo D de 3 entradas - Sí funciona
module FF3 (input wire clock, reset, input wire [2:0]D, output reg [2:0]Q);
always @ (posedge clock, posedge reset) begin
  if (reset) begin
    Q <= 3'b0;
    end
  else begin
    Q <= D;
    end
    end
endmodule

//Flip flop tipo D de 2 entradas - Sí funciona
module FF2 (input wire clock, reset, input wire [1:0]D, output reg [1:0]Q);
always @ (posedge clock, posedge reset) begin
  if (reset) begin
    Q <= 2'b0;
    end
  else begin
    Q <= D;
    end
    end
endmodule

//Flip flop tipo D de 1 entrada - Sí funciona
module FF1 (input wire clock, reset, input wire D, output reg Q);
always @ (posedge clock, posedge reset) begin
  if (reset) begin
    Q <= 1'b0;
    end
  else begin
    Q <= D;
    end
    end
endmodule

//Counter - No sé si funciona
module Counter (input wire clock, reset, input wire [7:0]maxvalue, output reg zero, output reg [7:0]value);
always @ (posedge clock, posedge reset) begin
  if (reset) begin
    value <= 8'b0;
    zero <= 1'b0;
    end
  else if (value < maxvalue) begin
    value <= value + 1;
    zero <= 1'b0;
    end
  else if (value == maxvalue) begin
    value <= 8'b0;
    zero <= 1'b1;
    end
    end
endmodule

//Máquinas
//Orden de asignación de variables:
//Anexo entre next state y current state con flip flop
//Definición de next state
//Definición de salida en relación a estados actuales -e inputs de ser mealy-


//Primera Máquina: Antirebote - Sí funciona
module Debounce (input wire Push, clock, reset, output wire Signal);
  //creación de variables locales para estados
  wire S, SN;
  //asignación de estados a través de flip flop
  FF1 D1(clock, reset, SN, S); //D1 por Debounce
  //lógica combinacional para estado futuro
  assign SN = Push;
  //lógica combinacional para salida
  assign Signal = ~S & Push;
endmodule

//Segunda Máquina: Confirmación - Sí funciona
module Confirm (input wire Signal, clock, reset, output wire [1:0]OK);
  wire [1:0]S;
  wire [1:0]SN;
  FF2 C1(clock, reset, SN, S); //C1 por Confirm
  assign SN[1] = (S[1] & ~S[0]) | (S[1] & ~Signal) | (~S[1] & S[0] & Signal);
  assign SN[0] = S[0] ^ Signal;
  assign OK[1] = S[1];
  assign OK[0] = S[0];
endmodule

//Tercera Máquina: Tamaño - Sí funciona
module Size (input wire Signal, clock, reset, input wire [1:0]OK, output wire [1:0]T);
  wire [1:0]S;
  wire [1:0]SN;
  FF2 S1(clock, reset, SN, S); //S1 por Size
  assign SN[1] = (S[1] & ~S[0]) | (S[1] & ~Signal) | (S[1] & OK[1]) | (S[1] & OK[0]) | (~S[1] & S[0] & Signal & ~OK[1] & ~OK[0]);
  assign SN[0] = (S[0] & ~Signal) | (S[0] & OK[1]) | (S[0] & OK[0]) | (~S[0] & Signal & ~OK[1] & ~OK[0]) | (S[1] & Signal & ~OK[1] & ~OK[0]);
  assign T[1] = S[1];
  assign T[0] = S[0];
endmodule

//Cuarta Máquina: Café - Sí funciona
module Coffee (input wire Signal, clock, reset, input wire [1:0]OK, output wire [1:0]C);
  wire [1:0]S;
  wire [1:0]SN;
  FF2 C1(clock, reset, SN, S); //C1 por Coffee
  assign SN[1] = (S[1] & ~S[0]) | (S[1] & ~Signal) | (S[1] & OK[1]) | (S[1] & ~OK[0]) | (~S[1] & S[0] & Signal & ~OK[1] & OK[0]);
  assign SN[0] = (S[0] & ~Signal) | (S[0] & OK[1]) | (S[0] & ~OK[0]) | (~S[0] & Signal & ~OK[1] & OK[0]) | (S[1] & Signal & ~OK[1] & OK[0]);
  assign C[1] = S[1];
  assign C[0] = S[0];
endmodule

//Quinta Máquina: Preparación - Sí funciona
module Prep (input wire TMR2, clock, reset, input wire [1:0]OK, output wire [1:0]M, output wire F, L1, TMR2ON);
  wire [2:0]S;
  wire [2:0]SN;
  FF3 P1(clock, reset, SN, S); //P1 por Prep
  assign SN[2] = (S[2] & OK[1] & OK[0]) | (S[1] & S[0] & TMR2);
  assign SN[1] = (S[1] & ~S[0]) | (S[1] & ~TMR2) | (~S[1] & S[0] & TMR2);
  assign SN[0] = (S[1] & ~S[0]) | (S[0] & ~TMR2) | (~S[2] & ~S[0] & OK[1] & OK[0]);
  assign M[1] = S[1] & S[0];
  assign M[0] = ~S[1] & S[0];
  assign F = S[1] | S[0];
  assign L1 = S[1];
  assign TMR2ON = S[0];
endmodule

//Sexta Máquina: Display - No funciona
module Display (input wire TMR1, F, clock, reset, input wire [1:0]OK, input wire [1:0]T, input wire [1:0]C, output wire [3:0]LCD, output wire TMR1ON);
  wire [3:0]S;
  wire [3:0]SN;
  FF4 D1(clock, reset, SN, S); //D1 por Display
  assign SN[3] = (S[3] & ~S[2]) | (S[3] & ~OK[1]) | (S[3] & ~OK[0]) | (S[3] & ~S[1] & ~S[0]) | (S[2] & S[1] & S[0] & C[1] & TMR1) | (S[2] & S[1] & S[0] & C[0] & TMR1);

  assign SN[2] = (~S[3] & S[2] & ~S[0]) | (S[2] & ~S[1] & ~S[0]) | (S[3] & S[2] & ~OK[1]) | (S[3] & S[2] & ~OK[0]) | (~S[3] & S[2] & ~S[1] & T[1]) | (S[3] & S[1] & S[0] & TMR1) | (S[2] & S[1] & S[0] & ~TMR1) | (~S[3] & ~S[2] & S[1] & S[0] & ~T[0]) | (S[2] & S[1] & S[0] & ~C[1] & ~C[0]) | (~S[3] & ~S[2] & S[1] & T[1] & TMR1) | (~S[3] & ~S[2] & S[1] & S[0] & ~OK[1] & OK[0]) | (S[3] & ~S[0] & C[1] & C[0] & OK[1] & ~OK[0]);

  assign SN[1] = (~S[3] & S[2] & S[1] & ~S[0]) | (~S[3] & S[2] & ~S[1] & ~T[1]) | (~S[3] & S[1] & ~S[0] & ~TMR1) | (S[3] & S[2] & ~S[1] & ~S[0] & TMR1) | (~S[3] & S[2] & ~S[1] & S[0] & ~OK[1] & OK[0]) | (S[3] & ~S[2] & ~S[1] & S[0] & OK[1] & ~OK[0]) | (~S[3] & ~S[2] & S[1] & ~T[1]) | (S[3] & S[1] & S[0] & ~TMR1) | (S[2] & S[1] & S[0] & ~TMR1) | (S[2] & S[1] & ~S[0] & ~OK[1]) | (S[2] & S[1] & ~S[0] & ~OK[0]) | (S[3] & ~S[2] & ~S[1] & C[1] & C[0]) | (S[2] & S[1] & S[0] & C[1] & C[0]) | (S[2] & S[1] & S[0] & ~C[1] & ~C[0]) | (S[3] & S[1] & ~S[0] & C[1] & ~OK[1]) | (S[3] & ~S[2] & ~S[0] & C[1] & C[0] & OK[0]) | (~S[3] & S[2] & ~S[0] & ~T[0] & ~OK[1] & OK[0]) | (S[3] & ~S[2] & ~S[1] & C[0] & OK[1] & ~OK[0]) | (~S[3] & ~S[2] & ~S[1] & S[0] & ~OK[1] & ~OK[0]);

  assign SN[0] = (S[3] & S[1] & S[0]) | (~S[3] & ~S[1] & S[0] & OK[1]) | (S[3] & S[2] & S[0] & ~OK[1]) | (~S[3] & S[2] & ~S[1] & ~S[0] & T[0]) | (~S[3] & S[2] & S[1] & ~S[0] & TMR1) | (~S[3] & S[1] & ~S[0] & T[0] & TMR1) | (~S[3] & ~S[2] & ~S[1] & ~S[0] & ~F) | (S[3] & ~S[2] & ~C[0]) | (S[2] & S[1] & S[0] & ~C[0]) | (S[2] & S[1] & S[0] & ~TMR1) | (S[2] & ~S[1] & S[0] & ~OK[0]) | (~S[2] & S[1] & S[0] & T[0] & OK[1]) | (~S[3] & ~S[2] & ~S[1] & S[0] & OK[0]) | (~S[3] & ~S[1] & S[0] & ~T[1] & OK[0]) | (~S[2] & S[1] & S[0] & T[0] & ~OK[0]) | (S[3] & ~S[2] & ~S[1] & ~S[0] & OK[1] & ~OK[0]);

  assign LCD[3] = S[3];
  assign LCD[2] = S[2];
  assign LCD[1] = S[1];
  assign LCD[0] = S[0];
  assign TMR1ON = (~S[3] & S[2] & S[1]) | (~S[3] & S[1] & ~S[0]) | (S[3] & ~S[2] & S[1] & S[0]) | (S[3] & S[2] & ~S[1] & ~S[0]);
endmodule

//Timer 1 con MaxValue fijo de 5 segundos - No sé si funciona
module Timer1 (input wire clock, TMR1ON, output wire TMR1);
  wire CLK, zero;
  wire [7:0]value;
  assign CLK = clock & TMR1ON;
  Counter T1(CLK, ~TMR1ON, 8'b00000101, zero, value);
  FF1 T2(zero, ~TMR1ON, 1'b1, TMR1);
endmodule

//Timer 2 con MaxValue variable según el tamaño - No sé si funciona
module Timer2 (input wire clock, TMR2ON, L1, input wire [1:0]T, input wire [1:0]C, output wire TMR2);
  wire CLK, zero1, zero2;
  wire [7:0]value1;
  wire [7:0]value2;
  wire [7:0]maxvalue1;
  wire [7:0]maxvalue2;
  assign CLK = clock & TMR2ON;
  assign maxvalue1[7:3] = 5'b00000;
  assign maxvalue1[2] = ~L1 & C[0];
  assign maxvalue1[1] = ~C[0] & C[1];
  assign maxvalue1[0] = (L1 & C[1]) | (L1 & C[0] & ~C[1]);
  assign maxvalue2[7:2] = 6'b000000;
  assign maxvalue2[1] = T[1];
  assign maxvalue2[0] = T[0];
  Counter T1(CLK, ~TMR2ON, maxvalue1, zero1, value1);
  Counter T2(zero1, ~TMR2ON, maxvalue2, zero2, value2);
  FF1 T3(zero2, ~TMR2ON, 1'b1, TMR2);
endmodule


module Cafetera(input wire clock, reset, PushS, PushC, output wire [1:0]M, output wire [3:0]LCD);
  wire SignalS, SignalC, F, TMR1, TMR1ON, TMR2, TMR2ON, L1;
  wire [1:0]OK;
  wire [1:0]T;
  wire [1:0]C;

  Debounce Select1(PushS, clock, reset, SignalS);
  Debounce Confirm1(PushC, clock, reset, SignalC);
  Confirm Okay1(SignalC, clock, reset, OK);
  Size Tama1(SignalS, clock, reset, OK, T);
  Coffee Cafe1(SignalS, clock, reset, OK, C);
  Display LCD1(TMR1, F, clock, reset, OK, T, C, LCD, TMR1ON);
  Timer1 T1(clock, TMR1ON, TMR1);
  Prep Prepa1(TMR2, clock, reset, OK, M, F, L1, TMR2ON);
  Timer2 T2(clock, TMR2ON, L1, T, C, TMR2);
endmodule
