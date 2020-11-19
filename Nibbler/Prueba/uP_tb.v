
module testbench();

  reg clock, reset;
  reg [3:0] pushbuttons;
  wire phase, c_flag, z_flag;
  wire [3:0] instr, oprnd, accu, data_bus, FF_out;
  wire [7:0] program_byte;
  wire [11:0] PC, address_RAM;

  integer nota = 0;
  integer immediateDelay = 16;
  integer jumpDelay = 276;
  integer memoryDelay = 0;

  uP uPmodule(.clock(clock),
              .reset(reset),
              .pushbuttons(pushbuttons),
              .phase(phase),
              .c_flag(c_flag),
              .z_flag(z_flag),
              .instr(instr),
              .oprnd(oprnd),
              .accu(accu),
              .data_bus(data_bus),
              .FF_out(FF_out),
              .program_byte(program_byte),
              .PC(PC),
              .address_RAM(address_RAM));

  initial
      #750 $finish;

  always
      #5 clock = ~clock;

  initial begin
      clock = 0; reset = 0; pushbuttons = 4'b0110; nota = 0;
      #2 reset = 1;
      #1 reset = 0;
      $display("\n");
      $display("Bienvenido al testbench de su proyecto");
      $display("\n");
      $display("Para facilitar el codigo del testbench la nota se ha");
      $display("multplicado por 10. Es decir, la nota maxima de esta");
      $display("prueba es de 900. Obviamente su nota en Canvas no sera de");
      $display("ese valor sino que se dividira dentro de 10.");
      $display("Es decir, su nota es sobre 9.0 puntos netos.");
      $display("\n");
  end

  initial begin
      $dumpfile("uP_tb.vcd");
      $dumpvars(0, testbench);
  end

  initial begin
      #immediateDelay
      if (PC === 12'h001 && accu === 4'hF) begin
          nota = nota + 70;
          $display("LIT funciona bien. Su nota es: %d/900\n", nota);
      end
      else
          $display("LIT NO funciona bien. Su nota es: %d/900\n", nota);
  end

  initial begin
      #(immediateDelay+20*1)
      if (PC === 12'h002 && accu === 4'hF && FF_out === 4'hF) begin
          nota = nota + 33;
          $display("OUT parece funcionar bien. Su nota es: %d/900\n", nota);
      end
      else
          $display("OUT NO funciona bien. Su nota es: %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 2)
      if (PC === 12'h003 && accu === 4'h6) begin
          nota = nota + 33;
          $display("IN parece funcionar bien. Su nota es: %d/900\n", nota);
      end
      else
          $display("IN NO funciona bien. Su nota es: %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 3)
      if (PC === 12'h004 && accu === 4'h0 && z_flag === 1'b1) begin
          $display("La bandera zero se encendio al colocar 4'b0000 en la salida de la ALU.\n");
      end
      else
          $display("La bandera zero NO se encendio al colocar 4'b0000 en la salida de la ALU.\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 5)
      if (PC === 12'h006 && accu === 4'h9 && c_flag === 1'b1) begin
          nota = nota + 33;
          $display("ADDI y la bandera carry funcionan bien. Su nota es: %d/900\n", nota);
      end
      else
          $display("ADDI y/o la bandera carry NO funcionan bien. Su nota es: %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 6)
      if (PC === 12'h007 && accu === 4'h9 && c_flag === 1'b0) begin
          nota = nota + 33;
          $display("CMPI de A > B hace que la bandera carry este en 0 (como deberia estar). Su nota es %d/900\n", nota);
      end
      else
          $display("CMPI de A > B causa que la bandera carry esté en 1 o modifico el valor del Accu. Su nota es %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 8)
      if (PC === 12'h009 && accu === 4'hA && c_flag === 1'b1) begin
          nota = nota + 33;
          $display("CMPI de A < B hace que la bandera carry este en 1 (como deberia estar). Su nota es %d/900\n", nota);
      end
      else
          $display("CMPI de A > B causa que la bandera carry este en 1 o modifico el valor del Accu.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 9)
      if (PC === 12'h00A && accu === 4'hB && c_flag === 1'b0 && z_flag === 1'b0) begin
          nota = nota + 33;
          $display("ADDI sin overflow no levanta las banderas (como deberia estar). Su nota es %d/900\n", nota);
      end
      else
          $display("ADDI sin overflow levanto alguna de las banderas o no realizo bien la suma.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 10)
      if (PC === 12'h00B && accu === 4'h4 && c_flag === 1'b0 && z_flag === 1'b0) begin
          nota = nota + 66;
          $display("NANDI funciona bien. Su nota es %d/900\n", nota);
      end
      else
          $display("NANDI NO funciona bien.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(immediateDelay + 20 * 11)
      if (PC === 12'h00C && accu === 4'h4 && c_flag === 1'b0 && z_flag === 1'b0 && FF_out === 4'h4) begin
          nota = nota + 33;
          $display("OUT funciona bien (la verificacion de OUT se hizo en 2 partes). Su nota es %d/900\n", nota);
      end
      else
          $display("OUT NO funciona bien (la verificacion de OUT se hizo en 2 partes).  Su nota es %d/900\n", nota);
      pushbuttons = 4'hE;
  end

  initial begin
      #(immediateDelay + 20 * 12)
      if (PC === 12'h00D && accu === 4'hE && c_flag === 1'b0 && z_flag === 1'b0 && FF_out === 4'h4) begin
          nota = nota + 33;
          $display("IN funciona bien (la verificacion de IN se hizo en 2 partes). Su nota es %d/900\n", nota);
      end
      else
          $display("IN NO funciona bien (la verificacion de IN se hizo en 2 partes).  Su nota es %d/900\n", nota);
      pushbuttons = 4'hE;

      $display("-----------------------------------------------------------------------------------------------------------------------------");
      $display("Hasta este punto se han verificado todas las instrucciones con inmediatos. Ahora se verificaran las instrucciones con saltos.");
      $display("La nota maxima (hasta este punto) es 400.\n");
  end

  initial begin
      #(jumpDelay)//276
      if (PC === 12'hA01) begin
          nota = nota + 60;
          $display("JMP funciona bien. Ahora estamos en PC = 12'hA01. Su nota es %d/900\n", nota);
      end
      else
          $display("JMP NO funciona bien. El PC no esta en la localidad 12'HA01.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(jumpDelay + 20 * 3) //336
      if (PC === 12'h050 && c_flag === 1'b1) begin
          nota = nota + 30;
          $display("JC parece funcionar bien con carry = 1 (1/2). Ahora estamos en PC = 12'h050. Su nota es %d/900\n", nota);
      end
      else
          $display("JC NO funciona bien. El PC no esta en la localidad 12'HA01 o carry no es 1.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(jumpDelay + 20 * 6)//396
      if (PC === 12'hF49 && z_flag === 1'b1) begin
          nota = nota + 30;
          $display("JZ parece funcionar bien con zero = 1 (1/2). Ahora estamos en PC = 12'hF49. Su nota es %d/900\n", nota);
      end
      else
          $display("JZ NO funciona bien. El PC no está en la localidad 12'hA01 ó zero no es 1.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(jumpDelay + 20 * 9)//456
      if (PC === 12'hF4D && z_flag === 1'b0 && c_flag === 1'b0 && accu === 4'h6) begin
          nota = nota + 30;
          $display("JC parece funcionar bien con carry = 0 (2/2). El PC aumento en +1 en vez de saltar. Su nota es %d/900\n", nota);
      end
      else
          $display("JC NO funciona bien. El PC salto a otra localidad o zero = 1 ó carry =1 ó por alguna razón su accu cambió de valor.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(jumpDelay + 20 * 10)//476
      if (PC === 12'hF4F && z_flag === 1'b0 && c_flag === 1'b0 && accu === 4'h6) begin
          nota = nota + 30;
          $display("JZ parece funcionar bien con zero = 0 (2/2). El PC aumento en +1 en vez de saltar. Su nota es %d/900\n", nota);
      end
      else
          $display("JZ NO funciona bien. El PC salto a otra localidad ó zero = 1 ó carry =1 o por alguna razon su accu cambió de valor.  Su nota es %d/900\n", nota);
  end

  initial begin
      #(jumpDelay + 20 * 11)//496
      if (PC === 12'h223 && z_flag === 1'b0 && c_flag === 1'b0 && accu === 4'h6) begin
          nota = nota + 30;
          $display("JNC parece funcionar bien con carry = 0 (1/2). El PC = 12'h223, c_flag = 0, z_flag = 0, accu = 4'h6. Su nota es %d/900\n", nota);
      end
      else
          $display("JNC NO funciona bien (2/2). El PC no esta en 12'h223, alguna bandera esta encendida o el accu cambio por alguna razon. Su nota es %d/900\n", nota);
  end

endmodule
