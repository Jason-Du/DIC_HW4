
`timescale 1ns/10ps
//`include "counter.v"
//`include "storing_reg.v"
//`include "bubble_sort.v"
module MFE(clk,reset,busy,ready,iaddr,idata,data_rd,data_wr,addr,wen);
	input				clk;
	input				reset;
	input				ready;	
	input	[7:0]		idata;	
	input	[7:0]		data_rd;
	
	
	output	[13:0]		iaddr;
	output reg		    busy;
	output	[ 7:0]		data_wr;
	output	[13:0]		addr;
	output reg			wen;
	

	
	reg [1:0] CS;
	reg [1:0] NS;
	localparam IDLE =2'b00;
	localparam STORING=2'b01;
	localparam SORTING=2'b10;
	localparam DONE=2'b11;
	reg       clear_C0;
	reg ready_out;
	wire [13:0]count_C0;
	reg       keep_C0;
	wire [7:0] value_1_1_B0;
	wire [7:0] value_1_2_B0;
	wire [7:0] value_1_3_B0;
	wire [7:0] value_2_1_B0;
	wire [7:0] value_2_2_B0;
	wire [7:0] value_2_3_B0;
	wire [7:0] value_3_1_B0;
	wire [7:0] value_3_2_B0;
	wire [7:0] value_3_3_B0;
counter C0(
	.clk(clk),
	.rst(reset),
	.count(count_C0),
	.clear(clear_C0),
	.keep(keep_C0)
);
reg start_B0;
wire finish_B0;
bubble_sort B0(
	.clk(clk),
	.rst(reset),
	.start(start_B0),
	.value_1_1(value_1_1_B0),
	.value_1_2(value_1_2_B0),
	.value_1_3(value_1_3_B0),
	.value_2_1(value_2_1_B0),
	.value_2_2(value_2_2_B0),
	.value_2_3(value_2_3_B0),
	.value_3_1(value_3_1_B0),
	.value_3_2(value_3_2_B0),
	.value_3_3(value_3_3_B0),

	.value_median(data_wr),
	.finish(finish_B0)
);
reg start_S0;
wire finish_S0;
storing_reg S0(
.clk(clk),
.rst(reset),
.start(start_S0),
.start_addr(count_C0),
.data_in(idata),

.value_1_1(value_1_1_B0),
.value_1_2(value_1_2_B0),
.value_1_3(value_1_3_B0),
.value_2_1(value_2_1_B0),
.value_2_2(value_2_2_B0),
.value_2_3(value_2_3_B0),
.value_3_1(value_3_1_B0),
.value_3_2(value_3_2_B0),
.value_3_3(value_3_3_B0),
.finish(finish_S0),
.addr(iaddr)
);
assign addr=count_C0;
	always@(posedge clk or posedge reset)
	begin
		if(reset)
		begin
			CS<=3'd0;
			ready_out<=1'd0;
		end
		else
		begin
			CS<=NS;
			ready_out<=ready;
		end
	
	end
	always@(*)
	begin
		case(CS)
			IDLE:
			begin
				if(reset)
				begin
					NS=IDLE;
					busy=1'b0;
					start_S0=1'b0;
					clear_C0=1'b1;
					keep_C0=1'b0;
					busy=1'b0;
				end
				else
				begin
					clear_C0=1'b0;
					keep_C0=1'b1;
					if(ready_out)
					begin
						NS=STORING;
						start_S0=1'b1;
						busy=1'b1;
					end
					else
					begin
						NS=IDLE;
						start_S0=1'b0;
						busy=1'b0;
					end
				end
				wen=1'b0;
				start_B0=1'd0;
			end
			STORING:
			begin
				NS=finish_S0?SORTING:STORING;
				start_S0=1'b1;
				busy=1'b1;
				clear_C0=1'b0;
				keep_C0=1'b1;
				start_B0=1'd0;
				wen=1'b0;
			end
			SORTING:
			begin
				start_S0=1'b0;
				NS=finish_B0?((count_C0==14'b11_1111_1111_1111)?DONE:STORING):SORTING;
				wen=finish_B0?1'b1:1'b0;
				busy=1'b1;
				clear_C0=1'b0;
				keep_C0=finish_B0?1'b0:1'b1;
				start_B0=1'd1;
			end
			DONE:
			begin
				start_S0=1'b0;
				NS=IDLE;
				wen=1'b0;
				busy=1'b0;
				clear_C0=1'b1;
				keep_C0=1'b0;
				start_B0=1'd0;
			end
		endcase
	end
endmodule
