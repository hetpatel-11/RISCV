`timescale 1ns/1ps

module instruction_memory_tb;

    reg [31:0] addr;
    wire [31:0] instruction;

    instruction_memory uut (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("instruction_memory_tb.vcd");
        $dumpvars(0, instruction_memory_tb);

        addr = 32'd0;
        #10;

        addr = 32'd4;
        #10;

        addr = 32'd8;
        #10;

        addr = 32'd12;
        #10;

        $display("Instruction memory testbench completed");
        $finish;
    end

endmodule
