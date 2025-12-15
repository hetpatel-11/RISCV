module riscv_cpu (
    input clk,
    input rst,
    output [31:0] gpio_out
);

    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] pc_plus_4;
    wire [31:0] instruction;

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    wire [3:0] alu_op;
    wire [2:0] imm_sel;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire reg_write;
    wire [1:0] wb_sel;
    wire branch;
    wire jump;

    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] immediate;
    wire [31:0] alu_operand_b;
    wire [31:0] alu_result;
    wire [31:0] mem_read_data;
    wire [31:0] write_back_data;
    wire branch_taken;
    wire [31:0] branch_target;
    wire [31:0] jump_target;

    assign pc_plus_4 = pc + 32'd4;
    assign branch_target = pc + immediate;
    assign jump_target = (opcode == 7'b1100111) ? (rs1_data + immediate) & ~32'd1 : branch_target;

    assign pc_next = (jump) ? jump_target :
                     (branch && branch_taken) ? branch_target :
                     pc_plus_4;

    program_counter pc_reg (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    instruction_memory imem (
        .addr(pc),
        .instruction(instruction)
    );

    decoder decode (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    control ctrl (
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

    wire [31:0] x1_reg;
    register_file regfile (
        .clk(clk),
        .rst(rst),
        .rs1_addr(rs1),
        .rs2_addr(rs2),
        .rd_addr(rd),
        .rd_data(write_back_data),
        .rd_we(reg_write),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .x1_out(x1_reg)
    );

    imm_gen immgen (
        .instruction(instruction),
        .imm_sel(imm_sel),
        .immediate(immediate)
    );

    assign alu_operand_b = (alu_src) ? immediate : rs2_data;

    wire [31:0] alu_operand_a;
    assign alu_operand_a = (opcode == 7'b0110111) ? 32'd0 :
                           (opcode == 7'b0010111) ? pc :
                           rs1_data;

    alu alu_unit (
        .operand_a(alu_operand_a),
        .operand_b(alu_operand_b),
        .alu_op(alu_op),
        .result(alu_result)
    );

    branch_comp branch_comparator (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .branch_op(funct3),
        .branch_taken(branch_taken)
    );

    data_memory dmem (
        .clk(clk),
        .addr(alu_result),
        .write_data(rs2_data),
        .funct3(funct3),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(mem_read_data)
    );

    assign write_back_data = (wb_sel == 2'b01) ? mem_read_data :
                             (wb_sel == 2'b10) ? pc_plus_4 :
                             alu_result;

    assign gpio_out = x1_reg;

endmodule
