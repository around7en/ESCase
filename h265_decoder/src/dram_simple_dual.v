//--------------------------------------------------------------------------------------------------
// Design    : bvp
// Author(s) : qiu bin, shi tian qi
// Email     : chat1@126.com, tishi1@126.com
// Copyright (C) 2013-2017 qiu bin, shi tian qi
// All rights reserved
// Phone 15957074161
// QQ:1517642772
//-------------------------------------------------------------------------------------------------


`include "defines.v"





// used for storing intra4x4_pred_mode, ref_idx, mvp etc
// 
module dram_simple
(
clk,
en,
we,
addra,
addrd,
doa,
did
);
parameter addr_bits = 6;
parameter data_bits = 8;
input     clk;
input     en;
input     we;
input     [addr_bits-1:0]  addra;
input     [addr_bits-1:0]  addrd;
input     [data_bits-1:0]  did;
output    [data_bits-1:0]  doa;


wire      clk;
wire      en;
wire      we;
wire      [addr_bits-1:0]  addra;
wire      [addr_bits-1:0]  addrd;

wire      [data_bits-1:0]  did;
wire      [data_bits-1:0]  doa;

(* ram_style = "distributed" *)
reg       [data_bits-1:0]  ram[0:(1 << addr_bits) -1];


`ifdef RANDOM_INIT
integer  seed;
integer random_val;
integer i;
initial  begin
    seed                               = $get_initial_random_seed(); 
    random_val                         = $random(seed);
    for (i=0;i<(1 << addr_bits);i=i+1)
        ram[i] = random_val;
end
`endif


//read
assign doa = ram[addra];

//write
always @ (posedge clk)
begin
    if (we && en)
        ram[addrd] <= did;
end

endmodule

