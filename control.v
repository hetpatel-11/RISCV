module control (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] alu_op,
    output reg [2:0] imm_sel,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg [1:0] wb_sel,
    output reg branch,
    output reg jump
);

    localparam OP_LOAD   = 7'b0000011;
    localparam OP_STORE  = 7'b0100011;
    localparam OP_BRANCH = 7'b1100011;
    localparam OP_JAL    = 7'b1101111;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_IMM    = 7'b0010011;
    localparam OP_REG    = 7'b0110011;
    localparam OP_LUI    = 7'b0110111;
    localparam OP_AUIPC  = 7'b0010111;

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_SLL  = 4'b0010;
    localparam ALU_SLT  = 4'b0011;
    localparam ALU_SLTU = 4'b0100;
    localparam ALU_XOR  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_OR   = 4'b1000;
    localparam ALU_AND  = 4'b1001;

    localparam IMM_I = 3'b000;
    localparam IMM_S = 3'b001;
    localparam IMM_B = 3'b010;
    localparam IMM_U = 3'b011;
    localparam IMM_J = 3'b100;

    localparam WB_ALU = 2'b00;
    localparam WB_MEM = 2'b01;
    localparam WB_PC4 = 2'b10;

    always @(*) begin
        alu_op = ALU_ADD;
        imm_sel = IMM_I;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        reg_write = 1'b0;
        wb_sel = WB_ALU;
        branch = 1'b0;
        jump = 1'b0;

        case (opcode)
            OP_LOAD: begin
                alu_op = ALU_ADD;
                imm_sel = IMM_I;
                alu_src = 1'b1;
                mem_read = 1'b1;
                reg_write = 1'b1;
                wb_sel = WB_MEM;
            end

            OP_STORE: begin
                alu_op = ALU_ADD;
                imm_sel = IMM_S;
                alu_src = 1'b1;
                mem_write = 1'b1;
            end

            OP_BRANCH: begin
                imm_sel = IMM_B;
                branch = 1'b1;
            end

            OP_JAL: begin
                imm_sel = IMM_J;
                reg_write = 1'b1;
                wb_sel = WB_PC4;
                jump = 1'b1;
            end

            OP_JALR: begin
                alu_op = ALU_ADD;
                imm_sel = IMM_I;
                alu_src = 1'b1;
                reg_write = 1'b1;
                wb_sel = WB_PC4;
                jump = 1'b1;
            end

            OP_IMM: begin
                imm_sel = IMM_I;
                alu_src = 1'b1;
                reg_write = 1'b1;
                wb_sel = WB_ALU;

                case (funct3)
                    3'b000: alu_op = ALU_ADD;
                    3'b010: alu_op = ALU_SLT;
                    3'b011: alu_op = ALU_SLTU;
                    3'b100: alu_op = ALU_XOR;
                    3'b110: alu_op = ALU_OR;
                    3'b111: alu_op = ALU_AND;
                    3'b001: alu_op = ALU_SLL;
                    3'b101: alu_op = (funct7[5]) ? ALU_SRA : ALU_SRL;
                    default: alu_op = ALU_ADD;
                endcase
            end

            OP_REG: begin
                alu_src = 1'b0;
                reg_write = 1'b1;
                wb_sel = WB_ALU;

                case (funct3)
                    3'b000: alu_op = (funct7[5]) ? ALU_SUB : ALU_ADD;
                    3'b001: alu_op = ALU_SLL;
                    3'b010: alu_op = ALU_SLT;
                    3'b011: alu_op = ALU_SLTU;
                    3'b100: alu_op = ALU_XOR;
                    3'b101: alu_op = (funct7[5]) ? ALU_SRA : ALU_SRL;
                    3'b110: alu_op = ALU_OR;
                    3'b111: alu_op = ALU_AND;
                    default: alu_op = ALU_ADD;
                endcase
            end

            OP_LUI: begin
                imm_sel = IMM_U;
                reg_write = 1'b1;
                wb_sel = WB_ALU;
                alu_op = ALU_ADD;
                alu_src = 1'b1;
            end

            OP_AUIPC: begin
                imm_sel = IMM_U;
                reg_write = 1'b1;
                wb_sel = WB_ALU;
                alu_op = ALU_ADD;
                alu_src = 1'b1;
            end

            default: begin
            end
        endcase
    end

endmodule
