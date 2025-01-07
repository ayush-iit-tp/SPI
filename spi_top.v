module top
(
input clk, rst, tx_enable,
output [7:0] dout,
output done
);
 
wire mosi, ss, sclk;
 
fsm_spi    spi_m (clk, rst, tx_enable, mosi, ss, sclk);
spi_slave  spi_s (sclk, mosi,ss, dout, done);
 
endmodule
