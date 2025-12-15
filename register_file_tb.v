`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg rst;
    reg [4:0] rs1_addr;
    reg [4:0] rs2_addr;
    reg [4:0] rd_addr;
    reg [31:0] rd_data;
    reg rd_we;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    register_file uut (
        .clk(clk),
        .rst(rst),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rd_we(rd_we),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("register_file_tb.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        rst = 1;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_data = 0;
        rd_we = 0;
        #10;

        rst = 0;
        #10;

        rd_addr = 5'd1;
        rd_data = 32'hDEADBEEF;
        rd_we = 1;
        #10;

        rd_addr = 5'd2;
        rd_data = 32'hCAFEBABE;
        #10;

        rd_we = 0;
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        #10;

        rd_addr = 5'd0;
        rd_data = 32'hFFFFFFFF;
        rd_we = 1;
        #10;

        rs1_addr = 5'd0;
        #10;

        $display("Register file testbench completed");
        $finish;
    end

endmodule
