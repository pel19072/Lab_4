module testbench();

    reg clock, reset;
    reg [3:0] pushbuttons;
    wire phase, c_flag, z_flag;
    wire [3:0] instr, oprnd, accu, data_bus, FF_out;
    wire [7:0] program_byte;
    wire [11:0] PC, address_RAM;

    integer nota = 0;

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
        #500 $finish;

    initial begin
        #84
        $display("PC: %h\taccu: %h",PC,accu);
        if (PC === 12'h124 && accu === 4'h4) begin
            nota = nota + 5;
            $display("ADDI funciona bien. Su nota es: %d", nota);
        end
        else
            $display("ADDI NO funciona bien. Su nota es: %d", nota);
    end

    always
        #5 clock = ~clock;

    initial begin
        clock = 0; reset = 0; pushbuttons = 4'b0110; nota = 0;
        #2 reset = 1;
        #1 reset = 0;
    end



    initial begin
        $dumpfile("uP_tb.vcd");
        $dumpvars(0, testbench);
    end

endmodule
