module program_counter (
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc
);

    initial begin
        pc = 32'd0;
    end

    always @(posedge clk) begin
        if (rst) begin
            pc <= 32'd0;
        end else begin
            pc <= pc_next;
        end
    end

endmodule
