//--------------------------------------------------------------------------------------------------
// Design    : bvp
// Author(s) : qiu bin, shi tian qi
// Email     : chat1@126.com, tishi1@126.com
// Copyright (C) 2013-2017 qiu bin, shi tian qi
// All rights reserved
// Phone 15957074161
// QQ:1517642772
//-------------------------------------------------------------------------------------------------

module multadd(
    clk    ,
    a      ,
    b      ,
    c      ,
    p
);
parameter a_bits = 6'd16;
parameter b_bits = 6'd8;
parameter c_bits = 6'd26;
parameter p_bits = 6'd26;

input  clk    ;
input  a      ;
input  b      ;
input  c      ;
(* use_dsp48 = "yes" *) 
output p      ;

wire clk;

wire signed  [a_bits-1:0]  a      ;
wire signed  [b_bits-1:0]  b      ;
wire signed  [c_bits-1:0]  c      ;
(* use_dsp48 = "yes" *)
reg  signed  [p_bits-1:0]  p      ;

always @(posedge clk)
begin
     p <= a*b+c;
end

endmodule

