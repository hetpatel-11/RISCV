module branch_comp (
    input [31:0] rs1_data,
    input [31:0] rs2_data,
    input [2:0] branch_op,
    output reg branch_taken
);

    localparam BR_EQ  = 3'b000;
    localparam BR_NE  = 3'b001;
    localparam BR_LT  = 3'b100;
    localparam BR_GE  = 3'b101;
    localparam BR_LTU = 3'b110;
    localparam BR_GEU = 3'b111;

    always @(*) begin
        case (branch_op)
            BR_EQ:  branch_taken = (rs1_data == rs2_data);
            BR_NE:  branch_taken = (rs1_data != rs2_data);
            BR_LT:  branch_taken = ($signed(rs1_data) < $signed(rs2_data));
            BR_GE:  branch_taken = ($signed(rs1_data) >= $signed(rs2_data));
            BR_LTU: branch_taken = (rs1_data < rs2_data);
            BR_GEU: branch_taken = (rs1_data >= rs2_data);
            default: branch_taken = 1'b0;
        endcase
    end

endmodule
