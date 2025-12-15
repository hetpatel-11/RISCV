`timescale 1ns/1ps

module riscv_cpu_tb;

    reg clk;
    reg rst;
    wire [31:0] gpio_out;

    riscv_cpu uut (
        .clk(clk),
        .rst(rst),
        .gpio_out(gpio_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("riscv_cpu_tb.vcd");
        $dumpvars(0, riscv_cpu_tb);

        clk = 0;
        rst = 1;
        #20;

        rst = 0;
        #200;

        $display("RISC-V CPU testbench completed");
        $finish;
    end

    always @(posedge clk) begin
        if (!rst) begin
            $display("Time=%0t PC=%h Instruction=%h GPIO=%h",
                     $time, uut.pc, uut.instruction, gpio_out);
        end
    end

endmodule
