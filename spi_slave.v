module spi_slave (
input sclk, mosi,cs,
output [7:0] dout,
output reg done 
);
 
integer count = 0;
typedef enum logic [1:0] {idle = 0, sample = 1 } state_type;
state_type state;
reg [7:0] data = 0;
 
  
always@(negedge sclk)
begin
case (state)
 
idle: begin
done <= 1'b0;
 
if(cs == 1'b0)
state <= sample;
else
state <= idle;
end
 
sample: 
begin
        if(count < 8)
        begin
        count <= count + 1;
        data <= {data[6:0],mosi};
        state <= sample;
        end
        else
        begin
        count <= 0;
        state <= idle;
        done  <= 1'b1;
        end
end
 
default : state <= idle;
endcase
 
end
 
assign dout = data;
 
endmodule
 
 
///////////////////////////////////////
 
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
