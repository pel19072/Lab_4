module testbench();
  //Variables de entrada
  reg [6:0]address; //microcode

  //Variables de salida
  wire [12:0]control; //microcode

  //Instanciaciones
  Microcode MC(address, control);

    // Ejercicio 5
    initial begin
    #2
    $display(" \nMicrocode ");
    $display("address  |    control   ");
    $display("---------|-------------");
    $monitor("%b  | %b", address, control);

        address = 7'bxxxxxx0; //0
    #2  address = 7'b00001x1; //1
    #2  address = 7'b00000x1; //2
    #2  address = 7'b00011x1; //3
    #2  address = 7'b00010x1; //4
    #2  address = 7'b0010xx1; //5
    #2  address = 7'b0011xx1; //6
    #2  address = 7'b0100xx1; //7
    #2  address = 7'b0101xx1; //8
    #2  address = 7'b0110xx1; //9
    #2  address = 7'b0111xx1; //10
    #2  address = 7'b1000x11; //11
    #2  address = 7'b1000x01; //12
    #2  address = 7'b1001x11; //13
    #2  address = 7'b1001x01; //14
    #2  address = 7'b1010xx1; //15
    #2  address = 7'b1011xx1; //16
    #2  address = 7'b1100xx1; //17
    #2  address = 7'b1101xx1; //18
    #2  address = 7'b1110xx1; //19
    #2  address = 7'b1111xx1; //20

    #2  address = 7'b01000x1; //7
    #2  address = 7'b0101x11; //8
    #2  address = 7'b0110111; //9
    #2  address = 7'b0111001; //10
    #2  address = 7'b1000011; //11
    #2  address = 7'b1000101; //12
    #2  address = 7'b1001011; //13
    #2  address = 7'b1001101; //14
    end

    initial
      #60 $finish;
    initial begin
        $dumpfile("code_tb.vcd");
        $dumpvars(0, testbench);
      end
  endmodule
