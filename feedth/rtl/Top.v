module Top
(
i_dum_c0,
o_dum_c0,
i_dum_c1,
o_dum_c1,
i_dum_d1,
o_dum_d1,
i_dum_d0,
o_dum_d0,
clk,
rst_n,
o_dum_sysN1, o_dum_sysN0,i_dum_sysN

)
;
input [15:0] i_dum_c0;
output [15:0] o_dum_c0;
input [15:0] i_dum_c1;
output [15:0] o_dum_c1;
input [15:0] i_dum_d0;
output [15:0] o_dum_d0;

input [15:0] i_dum_d1;
output [15:0] o_dum_d1;
input clk, rst_n;
output [15:0] o_dum_sysN1, o_dum_sysN0;
input [15:0] i_dum_sysN;

wire [511:0] fdt_f_0__a_0, fdt_a_1__h0, fdt_b_0__c_0, fdt_b_0__d_0, fdt_d_0__e_0, fdt_c_0__e_0;


F f_0_u_dont_touch (.o_fdt_fh(fdt_f_0__a_0));
SysN sys_0_u_dont_touch  (.i_fdt_f_0__a_0(fdt_f_0__a_0), .o_fdt_a_1__h_0(fdt_a_1__h0), .o_fdt_b_0__c_0(fdt_b_0__c_0), .o_fdt_b_0__d_0(fdt_b_0__d_0), .o_dum_sysN(o_dum_sysN0), .i_dum_sysN(i_dum_sysN));
C c_0_u_dont_touch  (.i_fdt_b_0__c_0(fdt_b_0__c_0), .o_fdt_c_0__e_0(fdt_c_0__e_0), .o_dum_c(o_dum_c0), .i_dum_c(i_dum_c0), .clk(clk), .rst_n(rst_n));
D d_0_u_dont_touch  (.i_fdt_b_0__d_0(fdt_b_0__d_0), .o_fdt_d_0__e_0(fdt_d_0__e_0), .o_dum_d(o_dum_d0), .i_dum_d(i_dum_d0), .clk(clk), .rst_n(rst_n));
E e_0_u_dont_touch  (.i_fdt_d_0__e_0(fdt_d_0__e_0), .i_fdt_c_0__e_0(fdt_c_0__e_0));
D d_1_u_dont_touch  (.i_fdt_b_0__d_0(), .o_fdt_d_0__e_0(), .o_dum_d(o_dum_d1), .i_dum_d(i_dum_d1), .clk(clk), .rst_n(rst_n));
C c_1_u_dont_touch  (.i_fdt_b_0__c_0(), .o_fdt_c_0__e_0(), .o_dum_c(o_dum_c1), .i_dum_c(i_dum_c1), .clk(clk), .rst_n(rst_n));
SysN sys_1_u_dont_touch  (.i_fdt_f_0__a_0(), .o_fdt_a_1__h_0(), .o_fdt_b_0__c_0(), .o_fdt_b_0__d_0(), .o_dum_sysN(o_dum_sysN1), .i_dum_sysN(i_dum_sysN));
H h_0_u_dont_touch (.i_fdt_fh (fdt_a_1__h0));

endmodule



module SysN(
i_fdt_f_0__a_0,
o_fdt_a_1__h_0,
o_fdt_b_0__c_0,
o_fdt_b_0__d_0,
o_dum_sysN,
i_dum_sysN

);

input [511:0] i_fdt_f_0__a_0;
output [511:0] o_fdt_a_1__h_0;
output [511:0] o_fdt_b_0__c_0;
output [511:0] o_fdt_b_0__d_0;
output [15:0] o_dum_sysN;
input [15:0] i_dum_sysN;

assign o_dum_sysN = 16'h0101 +i_dum_sysN ;

wire [511:0] fdt_a_0__a_1, fdt_a_0__b_0;
wire [15:0] con_ab0, con_ab1;

A a_0_u_dont_touch  (
    .i_fdt_f_0__a_0(i_fdt_f_0__a_0), 
    .o_fdt_a_1__h_0(), 
    .o_fdt_a_0__a_1(fdt_a_0__a_1), 
    .i_fdt_a_0__a_1(), 
    .o_con_ab(con_ab0), 
    .o_fdt_a_0__b_0(fdt_a_0__b_0)
);
A a_1_u_dont_touch  (
    .i_fdt_f_0__a_0(), 
    .o_fdt_a_1__h_0(o_fdt_a_1__h_0), 
    .o_fdt_a_0__a_1(), 
    .i_fdt_a_0__a_1(fdt_a_0__a_1), 
    .o_con_ab(con_ab1), 
    .o_fdt_a_0__b_0()
);
B b_0_u_dont_touch (
    .i_con_ab(con_ab0), 
    .i_fdt_a_0__b_0(fdt_a_0__b_0), 
    .o_fdt_b_0__c_0(o_fdt_b_0__c_0), 
    .o_fdt_b_0__d_0(o_fdt_b_0__d_0)
);
B b_1_u_dont_touch (
    .i_con_ab(con_ab1), 
    .i_fdt_a_0__b_0(), 
    .o_fdt_b_0__c_0(), 
    .o_fdt_b_0__d_0()
);



endmodule

module A(i_fdt_f_0__a_0, o_fdt_a_1__h_0, o_fdt_a_0__a_1, i_fdt_a_0__a_1, o_con_ab, o_fdt_a_0__b_0);

input [511:0] i_fdt_f_0__a_0;

output [511:0] o_fdt_a_1__h_0;
output [511:0] o_fdt_a_0__a_1;
input  [511:0] i_fdt_a_0__a_1;
output [15:0] o_con_ab;
output [511:0] o_fdt_a_0__b_0; 

assign o_fdt_a_0__a_1 = i_fdt_f_0__a_0;
assign o_fdt_a_1__h_0 = i_fdt_a_0__a_1;

assign o_con_ab = 16'habcd;
assign o_fdt_a_0__b_0 = 512'habcdabcd;

endmodule



module B (i_con_ab, i_fdt_a_0__b_0, o_fdt_b_0__c_0, o_fdt_b_0__d_0);

input [15:0] i_con_ab;
input [511:0] i_fdt_a_0__b_0;

output [511:0] o_fdt_b_0__c_0;
output [511:0] o_fdt_b_0__d_0;

assign o_fdt_b_0__c_0 = i_fdt_a_0__b_0;
assign o_fdt_b_0__d_0 = i_fdt_a_0__b_0;

endmodule


module C(i_fdt_b_0__c_0, o_fdt_c_0__e_0, o_dum_c, i_dum_c,clk,rst_n);
input [511:0] i_fdt_b_0__c_0;
output [511:0] o_fdt_c_0__e_0;
input [15:0] i_dum_c;
output reg [15:0] o_dum_c;
input clk, rst_n;

assign  o_fdt_c_0__e_0 = i_fdt_b_0__c_0;


always @(posedge clk or negedge rst_n) begin
    if(!rst_n)      o_dum_c <= 16'h0;
    else            o_dum_c <= i_dum_c + 16'hbbbb;
end


endmodule

module D(
    i_fdt_b_0__d_0,
    o_fdt_d_0__e_0,
    o_dum_d,
    i_dum_d,
    clk,
    rst_n
);
input [511:0] i_fdt_b_0__d_0;
output [511:0] o_fdt_d_0__e_0;
input [15:0] i_dum_d;
output reg [15:0] o_dum_d;
input clk, rst_n;

assign o_fdt_d_0__e_0 = i_fdt_b_0__d_0;


always @(posedge clk or negedge rst_n) begin
    if(!rst_n)      o_dum_d <= 16'h0;
    else            o_dum_d <= i_dum_d + 16'hbbbb;
end


endmodule


module E (i_fdt_d_0__e_0, i_fdt_c_0__e_0);

input [511:0] i_fdt_d_0__e_0, i_fdt_c_0__e_0;


endmodule


module F (o_fdt_fh);

output [511:0] o_fdt_fh;

assign o_fdt_fh = 512'habcdabcdabcd;

endmodule 


module H (i_fdt_fh);
input  [511:0] i_fdt_fh;

endmodule
