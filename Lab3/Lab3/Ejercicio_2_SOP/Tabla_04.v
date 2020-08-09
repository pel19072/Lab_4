// -----------------------------------
// Ricardo Pellecer Orellana
// Carné: 19072
// 31/Julio/2020
// Tabla_04_SOP
// -----------------------------------
module tabla_4_SOP();	// generar y nombrar un módulo
  
// Cables

wire n_out1, n_out2, n_out3; // Cables que salen de los not
wire a_out1, a_out2, a_out3;// Cable que sale del and
wire o_out1; // Cable que salen de los or

// Entradas

reg input1, input2, input3;	

// Compuertas

// Not's  
not N1 (n_out1, input1);
not N2 (n_out2, input2);
not N3 (n_out3, input3);


// And's

and A1 (a_out1, n_out1, n_out2, input3);
and A2 (a_out2, input1, input2, n_out3);
and A3 (a_out3, input1, input2, input3);

// Or's

or O1 (o_out1, a_out1, a_out2, a_out3);


// Inicio de simulación
initial begin	
  //monitor nos permite rastrear cambios en las entradas y salidas
  // %b = binario %d = decimal %h = hex  \t = tabulación
  
  $display("A B C | Y");
  $display("-------");
  
  $monitor("%b %b %b | %b", input1, input2, input3, o_out1); 
  // Valores de inputs iniciales
  input1 = 0;
  input2 = 0;
  input3 = 0;
 
  // Cambios para la tabla de verdad
  #1 input1 = 0; input2 = 0; input3 = 1;
  #1 input1 = 0; input2 = 1; input3 = 0;
  #1 input1 = 0; input2 = 1; input3 = 1;  
  #1 input1 = 1; input2 = 0; input3 = 0;
  #1 input1 = 1; input2 = 0; input3 = 1;
  #1 input1 = 1; input2 = 1; input3 = 0;
  #1 input1 = 1; input2 = 1; input3 = 1;
  
  #1 $finish;   // termina la simulación
end	

 
  initial 
    begin
      $dumpfile("Tabla_04_tb.vcd"); // noten que el nombre del archivo siempre es el que incluye el _tb y la extension es .vcd
      $dumpvars(0, tabla_4_SOP); // noten que el nombre que está después del número 0 es el mismo que el nombre del módulo que estamos probando
    end 
endmodule	//finalizar el módulo
