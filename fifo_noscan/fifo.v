`timescale 1ns/1ns
module fifo(clock,reset,pin,sin,din,pout,dout);

input clock,reset; //clock, reset signals

input pin, sin; //input flags

input [8:0] din;

output pout ; 

output [8:0] dout;


reg full,empty ;


reg mwrite, mread; 

reg [4:0] fullw,mem_w,fullr,mem_r; 

reg pout;

assign S0 = mem_w[4] ;


mem32x9 mem (.clock   (clock),
             .waddr (mem_w), 
             .wdata (din), 
             .write (mwrite),
             .raddr (mem_r), 
             .rdata (dout)
            );

always @ (*)
begin


  if((mem_w + 1) == mem_r)
    full = 1'b1 ;
  else 
    full = 1'b0 ; 

  if(mem_w == mem_r)
    empty = 1'b1 ;
  else 
    empty = 1'b0 ; 


  mwrite = pin & !full ;
  mread = !sin & !empty;


  if(mwrite) 
    fullw = mem_w + 1'b1 ; else 
    fullw = mem_w  ;


  if(mread) 
    fullr = mem_r + 1'b1 ; else 
    fullr = mem_r  ;


  if(!empty)
    pout = 1'b1;
  else 
    pout = 1'b0;
end


always @ (posedge clock or posedge(reset))
begin
  if(reset) begin
    mem_w <= 0;
  end else begin
    mem_w <= #1  fullw ;
  end
end


always @ (posedge clock or posedge(reset))
begin
  if(reset) begin
    mem_r <= 0;
  end else begin
  mem_r <= #1 fullr;
  end
end

endmodule





`timescale 1ns/10ps

module mem32x9(input clock,input [4:0] waddr, 
    input [8:0] wdata, input write,
    input [4:0] raddr, output [8:0] rdata);


reg [8:0] mem[0:31];

reg [8:0] rdataf;


assign rdata = rdataf;

always @(*) begin
  rdataf <= #2 mem[raddr];
end

always @(posedge(clock)) begin
  if(write) begin
    mem[waddr]<=#2 wdata;
  end
end

endmodule
