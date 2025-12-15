`timescale 1ns/1ps

module imm_gen_tb;

    reg [31:0] instruction;
    reg [2:0] imm_sel;
    wire [31:0] immediate;

    imm_gen uut (
        .instruction(instruction),
        .imm_sel(imm_sel),
        .immediate(immediate)
    );

    initial begin
        $dumpfile("imm_gen_tb.vcd");
        $dumpvars(0, imm_gen_tb);

        instruction = 32'hFFF00093;
        imm_sel = 3'b000;
        #10;

        instruction = 32'h00112023;
        imm_sel = 3'b001;
        #10;

        instruction = 32'h00000063;
        imm_sel = 3'b010;
        #10;

        instruction = 32'h12345037;
        imm_sel = 3'b011;
        #10;

        instruction = 32'h000000EF;
        imm_sel = 3'b100;
        #10;

        $display("Immediate generator testbench completed");
        $finish;
    end

endmodule
