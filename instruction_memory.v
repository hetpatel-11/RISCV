module instruction_memory (
    input [31:0] addr,
    output [31:0] instruction
);

    reg [31:0] mem [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'h00000013;
        end

        mem[0] = 32'h00100093;   // addi x1, x0, 1
        mem[1] = 32'h00200093;   // addi x1, x0, 2
        mem[2] = 32'h00400093;   // addi x1, x0, 4
        mem[3] = 32'hFF5FF06F;   // jal x0, -12
    end

    assign instruction = mem[addr[31:2]];

endmodule
