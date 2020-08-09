// -----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 31/Julio/2020
// Tabla_05_POS
// -----------------------------------
module tabla_5_POS();	// generar y nombrar un módulo
  
// Cables

wire n_out1, n_out2, n_out3, n_out4; // Cables que salen de los not
wire o_out1, o_out2, o_out3, o_out4, o_out5, o_out6, o_out7, o_out8, o_out9; // Cable que salen de los or
wire a_out1; // Cable que sale del and

// Entradas

reg input1, input2, input3, input4;	

// Compuertas: Nótese que se coloca en el formato (salida, entrada)

// Not's  
not N1 (n_out1, input1);
not N2 (n_out2, input2);
not N3 (n_out3, input3);
not N4 (n_out4, input4);

// Or's

or O1 (o_out1, input1, n_out2, input3, input4);
or O2 (o_out2, input1, n_out2, input3, n_out4);
or O3 (o_out3, input1, n_out2, n_out3, input4);
or O4 (o_out4, input1, n_out2, n_out3, n_out4);
or O5 (o_out5, n_out1, input2, input3, n_out4);
or O6 (o_out6, n_out1, input2, n_out3, n_out4);
or O7 (o_out7, n_out1, n_out2, input3, input4);
or O8 (o_out8, n_out1, n_out2, input3, n_out4);
or O9 (o_out9, n_out1, n_out2, n_out3, n_out4);

// And's

and A1 (a_out1, o_out1, o_out2, o_out3, o_out4, o_out5, o_out6, o_out7, o_out8, o_out9);


// Inicio de simulación
initial begin	
  //monitor nos permite rastrear cambios en las entradas y salidas
  // %b = binario %d = decimal %h = hex  \t = tabulación
  
  $display("A B C D | Y");
  $display("-------");
  
  $monitor("%b %b %b %b | %b", input1, input2, input3, input4, a_out1); 
  // Valores de inputs iniciales
  input1 = 0;
  input2 = 0;
  input3 = 0;
  input4 = 0;
 
  // Cambios para la tabla de verdad
  #1 input1 = 0; input2 = 0; input3 = 0; input4 = 1;
  #1 input1 = 0; input2 = 0; input3 = 1; input4 = 0;
  #1 input1 = 0; input2 = 0; input3 = 1; input4 = 1;
  #1 input1 = 0; input2 = 1; input3 = 0; input4 = 0;
  #1 input1 = 0; input2 = 1; input3 = 0; input4 = 1;
  #1 input1 = 0; input2 = 1; input3 = 1; input4 = 0;
  #1 input1 = 0; input2 = 1; input3 = 1; input4 = 1;
  #1 input1 = 1; input2 = 0; input3 = 0; input4 = 0;
  #1 input1 = 1; input2 = 0; input3 = 0; input4 = 1;
  #1 input1 = 1; input2 = 0; input3 = 1; input4 = 0;
  #1 input1 = 1; input2 = 0; input3 = 1; input4 = 1;
  #1 input1 = 1; input2 = 1; input3 = 0; input4 = 0;
  #1 input1 = 1; input2 = 1; input3 = 0; input4 = 1;
  #1 input1 = 1; input2 = 1; input3 = 1; input4 = 0;
  #1 input1 = 1; input2 = 1; input3 = 1; input4 = 1;
  
  #1 $finish;   // termina la simulación
end	

 
  initial 
    begin
      $dumpfile("Tabla_05_tb.vcd"); // noten que el nombre del archivo siempre es el que incluye el _tb y la extension es .vcd
      $dumpvars(0, tabla_5_POS); // noten que el nombre que está después del número 0 es el mismo que el nombre del módulo que estamos probando
    end 
endmodule	//finalizar el módulo
