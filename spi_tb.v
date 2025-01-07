module tb;
 
    reg clk = 0;
    reg rst = 0;
    reg tx_enable = 0;
    wire [7:0] dout;
    
    
    always #5 clk = ~clk;
    
    initial begin
    rst = 1;
    repeat(5) @(posedge clk);
    rst = 0;
    end
 
    initial begin
    tx_enable = 0;
    repeat(5) @(posedge clk);
    tx_enable = 1;
    end
 
top dut (clk, rst, tx_enable, dout);
 
endmodule
