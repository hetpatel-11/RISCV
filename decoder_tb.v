`timescale 1ns/1ps

module decoder_tb;

    reg [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    decoder uut (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    initial begin
        $dumpfile("decoder_tb.vcd");
        $dumpvars(0, decoder_tb);

        instruction = 32'h00000033;
        #10;

        instruction = 32'h00108093;
        #10;

        instruction = 32'h00000013;
        #10;

        instruction = 32'h00112023;
        #10;

        instruction = 32'h00000063;
        #10;

        $display("Decoder testbench completed");
        $finish;
    end

endmodule
