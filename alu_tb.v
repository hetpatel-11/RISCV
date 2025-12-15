`timescale 1ns/1ps

module alu_tb;

    reg [31:0] operand_a;
    reg [31:0] operand_b;
    reg [3:0] alu_op;
    wire [31:0] result;

    alu uut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_op(alu_op),
        .result(result)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        operand_a = 32'd10;
        operand_b = 32'd5;
        alu_op = 4'b0000;
        #10;

        alu_op = 4'b0001;
        #10;

        operand_a = 32'd8;
        operand_b = 32'd2;
        alu_op = 4'b0010;
        #10;

        operand_a = 32'sd5;
        operand_b = 32'sd10;
        alu_op = 4'b0011;
        #10;

        operand_a = 32'hFFFF;
        operand_b = 32'h00FF;
        alu_op = 4'b0101;
        #10;

        operand_a = 32'd16;
        operand_b = 32'd2;
        alu_op = 4'b0110;
        #10;

        operand_a = 32'hFFFFFFFF;
        operand_b = 32'd4;
        alu_op = 4'b0111;
        #10;

        operand_a = 32'hF0F0;
        operand_b = 32'h0F0F;
        alu_op = 4'b1000;
        #10;

        operand_a = 32'hF0F0;
        operand_b = 32'h0F0F;
        alu_op = 4'b1001;
        #10;

        $display("ALU testbench completed");
        $finish;
    end

endmodule
