`timescale 1ns/1ps

module data_memory_tb;

    reg clk;
    reg [31:0] addr;
    reg [31:0] write_data;
    reg [2:0] funct3;
    reg mem_read;
    reg mem_write;
    wire [31:0] read_data;

    data_memory uut (
        .clk(clk),
        .addr(addr),
        .write_data(write_data),
        .funct3(funct3),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("data_memory_tb.vcd");
        $dumpvars(0, data_memory_tb);

        clk = 0;
        addr = 32'd0;
        write_data = 32'd0;
        funct3 = 3'b010;
        mem_read = 0;
        mem_write = 0;
        #10;

        addr = 32'd0;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        #10;

        mem_write = 0;
        mem_read = 1;
        #10;

        addr = 32'd4;
        write_data = 32'hCAFEBABE;
        mem_read = 0;
        mem_write = 1;
        #10;

        mem_write = 0;
        mem_read = 1;
        #10;

        funct3 = 3'b000;
        addr = 32'd0;
        write_data = 32'h000000FF;
        mem_read = 0;
        mem_write = 1;
        #10;

        mem_write = 0;
        mem_read = 1;
        #10;

        $display("Data memory testbench completed");
        $finish;
    end

endmodule
