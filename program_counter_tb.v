`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg rst;
    reg [31:0] pc_next;
    wire [31:0] pc;

    program_counter uut (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("program_counter_tb.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        rst = 1;
        pc_next = 32'd0;
        #10;

        rst = 0;
        pc_next = 32'd4;
        #10;

        pc_next = 32'd8;
        #10;

        pc_next = 32'd12;
        #10;

        pc_next = 32'd100;
        #10;

        rst = 1;
        #10;

        rst = 0;
        pc_next = 32'd4;
        #10;

        $display("Program counter testbench completed");
        $finish;
    end

endmodule
