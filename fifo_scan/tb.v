`timescale 1ns/1ns
module tb();

wire [8:0] dout;
wire pout, S0;
reg clock, reset, pin, sin, TM, SI;
reg [8:0] din;


fifo m1 (clock,reset,pin,sin,din,pout,dout, TM, SI, S0);

initial
begin
	clock=0;
	pin=1;
	reset=1;
	#5 reset = 0;
	TM = 1;
	SI = 1;

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
	$dumpfile("tb.vcd");
end


endmodule
