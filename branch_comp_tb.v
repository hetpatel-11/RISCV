`timescale 1ns/1ps

module branch_comp_tb;

    reg [31:0] rs1_data;
    reg [31:0] rs2_data;
    reg [2:0] branch_op;
    wire branch_taken;

    branch_comp uut (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .branch_op(branch_op),
        .branch_taken(branch_taken)
    );

    initial begin
        $dumpfile("branch_comp_tb.vcd");
        $dumpvars(0, branch_comp_tb);

        rs1_data = 32'd10;
        rs2_data = 32'd10;
        branch_op = 3'b000;
        #10;

        branch_op = 3'b001;
        #10;

        rs1_data = 32'd5;
        rs2_data = 32'd10;
        branch_op = 3'b100;
        #10;

        branch_op = 3'b101;
        #10;

        rs1_data = 32'hFFFFFFFF;
        rs2_data = 32'd1;
        branch_op = 3'b110;
        #10;

        branch_op = 3'b111;
        #10;

        $display("Branch comparator testbench completed");
        $finish;
    end

endmodule
