module data_memory (
    input clk,
    input [31:0] addr,
    input [31:0] write_data,
    input [2:0] funct3,
    input mem_read,
    input mem_write,
    output reg [31:0] read_data
);

    reg [31:0] mem [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'd0;
        end
    end

    wire [7:0] word_addr = addr[9:2];

    always @(posedge clk) begin
        if (mem_write) begin
            case (funct3)
                3'b000: begin
                    case (addr[1:0])
                        2'b00: mem[word_addr][7:0]   <= write_data[7:0];
                        2'b01: mem[word_addr][15:8]  <= write_data[7:0];
                        2'b10: mem[word_addr][23:16] <= write_data[7:0];
                        2'b11: mem[word_addr][31:24] <= write_data[7:0];
                    endcase
                end
                3'b001: begin
                    case (addr[1])
                        1'b0: mem[word_addr][15:0]  <= write_data[15:0];
                        1'b1: mem[word_addr][31:16] <= write_data[15:0];
                    endcase
                end
                3'b010: mem[word_addr] <= write_data;
                default: mem[word_addr] <= write_data;
            endcase
        end
    end

    always @(*) begin
        if (mem_read) begin
            case (funct3)
                3'b000: begin
                    case (addr[1:0])
                        2'b00: read_data = {{24{mem[word_addr][7]}}, mem[word_addr][7:0]};
                        2'b01: read_data = {{24{mem[word_addr][15]}}, mem[word_addr][15:8]};
                        2'b10: read_data = {{24{mem[word_addr][23]}}, mem[word_addr][23:16]};
                        2'b11: read_data = {{24{mem[word_addr][31]}}, mem[word_addr][31:24]};
                    endcase
                end
                3'b001: begin
                    case (addr[1])
                        1'b0: read_data = {{16{mem[word_addr][15]}}, mem[word_addr][15:0]};
                        1'b1: read_data = {{16{mem[word_addr][31]}}, mem[word_addr][31:16]};
                    endcase
                end
                3'b010: read_data = mem[word_addr];
                3'b100: begin
                    case (addr[1:0])
                        2'b00: read_data = {24'd0, mem[word_addr][7:0]};
                        2'b01: read_data = {24'd0, mem[word_addr][15:8]};
                        2'b10: read_data = {24'd0, mem[word_addr][23:16]};
                        2'b11: read_data = {24'd0, mem[word_addr][31:24]};
                    endcase
                end
                3'b101: begin
                    case (addr[1])
                        1'b0: read_data = {16'd0, mem[word_addr][15:0]};
                        1'b1: read_data = {16'd0, mem[word_addr][31:16]};
                    endcase
                end
                default: read_data = mem[word_addr];
            endcase
        end else begin
            read_data = 32'd0;
        end
    end

endmodule
