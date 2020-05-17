`timescale 1ns/1ns
module fifo(clock,reset,pin,sin,din,pout,dout, TM, SI, S0);

input clock,reset; 

input pin, sin; 

input [8:0] din;

output pout ; 

output [8:0] dout;

output S0;

input TM, SI; 

reg full,empty ;  


reg mem_write, mem_read; 

reg [4:0] full_w,memw,full_r,memr; 

reg pout;

assign S0 = memw[4] ; 


mem32x9 mem (.clock   (clock),
             .waddr (memw), 
             .wdata (din), 
             .write (mem_write),
             .raddr (memr), 
             .rdata (dout)
            );

always @ (*)
begin


  if((memw + 1) == memr)
    full = 1'b1 ;
  else 
    full = 1'b0 ; 


  if(memw == memr)
    empty = 1'b1 ;
  else 
    empty = 1'b0 ; 


  mem_write = pin & !full ;


  mem_read = !sin & !empty;


  if(mem_write) 
    full_w = memw + 1'b1 ; else 
    full_w = memw  ;

  if(mem_read) 
    full_r = memr + 1'b1 ; else 
    full_r = memr  ;


  if(!empty)
    pout = 1'b1;
  else 
    pout = 1'b0;
end


always @ (posedge clock or posedge(reset))
begin
  if(reset) begin
    	memw <= 0;
  end else begin
 	memw <= #1 ( (TM)? ({memw[3:0], memr[4]}): full_w );
    //memw <= #1  _memw ;
  end
end

always @ (posedge clock or posedge(reset))
begin
  if(reset) begin
    	memr <= 0;
  end else begin
   	memr <= #1 ( (TM)? ({memr[3:0], SI}): full_r );
  //memr <= #1 _memr;
  end
end

endmodule

//memory--32x64 for a single FIFO

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
