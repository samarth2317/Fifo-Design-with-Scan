`timescale 1ns/1ns
module tb();

wire [8:0] dout;
wire pout;
reg clock, reset, pin, sin;
reg [8:0] din;


fifo m1 (clock,reset,pin,sin,din,pout,dout);

initial
begin
	clock=0;
	pin=1;
	reset=1;
	#5 reset = 0;

end
always @(posedge clock) begin
	sin= #1 $random;
	din = #1 $random;
end


always #1 clock = ~clock;

initial
begin
	#7000 $finish;
end
initial
begin
	$dumpvars(0,tb);
	$dumpfile("wave.vcd");
end


endmodule
