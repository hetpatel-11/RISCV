`timescale 1ns/1ps

module control_tb;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire [3:0] alu_op;
    wire [2:0] imm_sel;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire reg_write;
    wire [1:0] wb_sel;
    wire branch;
    wire jump;

    control uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_op(alu_op),
        .imm_sel(imm_sel),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .wb_sel(wb_sel),
        .branch(branch),
        .jump(jump)
    );

    initial begin
        $dumpfile("control_tb.vcd");
        $dumpvars(0, control_tb);

        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        funct7 = 7'b0100000;
        #10;

        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        opcode = 7'b0000011;
        funct3 = 3'b010;
        #10;

        opcode = 7'b0100011;
        funct3 = 3'b010;
        #10;

        opcode = 7'b1100011;
        funct3 = 3'b000;
        #10;

        opcode = 7'b1101111;
        #10;

        opcode = 7'b1100111;
        #10;

        opcode = 7'b0110111;
        #10;

        opcode = 7'b0010111;
        #10;

        $display("Control testbench completed");
        $finish;
    end

endmodule
