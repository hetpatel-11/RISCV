module top (
    output wire led_blue,
    output wire led_green,
    output wire led_red
);

    wire clk;
    SB_HFOSC inthosc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    reg rst;
    reg [7:0] rst_counter;
    wire [31:0] gpio_out;

    initial begin
        rst = 1'b1;
        rst_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (rst_counter < 8'd50) begin
            rst_counter <= rst_counter + 1;
            rst <= 1'b1;
        end else begin
            rst <= 1'b0;
        end
    end

    riscv_cpu cpu (
        .clk(clk),
        .rst(rst),
        .gpio_out(gpio_out)
    );

    SB_RGBA_DRV rgb (
        .RGBLEDEN (1'b1),
        .RGB0PWM  (gpio_out[0]),
        .RGB1PWM  (gpio_out[1]),
        .RGB2PWM  (gpio_out[2]),
        .CURREN   (1'b1),
        .RGB0     (led_blue),
        .RGB1     (led_green),
        .RGB2     (led_red)
    );
    defparam rgb.CURRENT_MODE = "0b1";
    defparam rgb.RGB0_CURRENT = "0b000001";
    defparam rgb.RGB1_CURRENT = "0b000001";
    defparam rgb.RGB2_CURRENT = "0b000001";

endmodule
