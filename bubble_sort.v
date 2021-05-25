module bubble_sort(
	clk,
	rst,
	start,
	value_1_1,
	value_1_2,
	value_1_3,
	value_2_1,
	value_2_2,
	value_2_3,
	value_3_1,
	value_3_2,
	value_3_3,

	value_median,
	finish
);
	input clk;
	input rst;
	input [7:0] value_1_1;
	input [7:0] value_1_2;
	input [7:0] value_1_3;
	input [7:0] value_2_1;
	input [7:0] value_2_2;
	input [7:0] value_2_3;
	input [7:0] value_3_1;
	input [7:0] value_3_2;
	input [7:0] value_3_3;
	input start;

	reg [7:0] value_1_1_out;
	reg [7:0] value_1_2_out;
	reg [7:0] value_1_3_out;
	reg [7:0] value_2_1_out;
	reg [7:0] value_2_2_out;
	reg [7:0] value_2_3_out;
	reg [7:0] value_3_1_out;
	reg [7:0] value_3_2_out;
	reg [7:0] value_3_3_out;
	
	reg [7:0] value_1_1_out2;
	reg [7:0] value_1_2_out2;
	reg [7:0] value_1_3_out2;
	reg [7:0] value_2_1_out2;
	reg [7:0] value_2_2_out2;
	reg [7:0] value_2_3_out2;
	reg [7:0] value_3_1_out2;
	reg [7:0] value_3_2_out2;
	reg [7:0] value_3_3_out2;

	output [7:0] value_median;
	output reg finish;
	
	reg [8:0] count;
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			 value_1_1_out<=8'd0;
			 value_1_2_out<=8'd0;
			 value_1_3_out<=8'd0;
			 value_2_1_out<=8'd0;
			 value_2_2_out<=8'd0;
			 value_2_3_out<=8'd0;
			 value_3_1_out<=8'd0;
			 value_3_2_out<=8'd0;
			 value_3_3_out<=8'd0;
			 value_1_1_out2<=8'd0;
			 value_1_2_out2<=8'd0;
			 value_1_3_out2<=8'd0;
			 value_2_1_out2<=8'd0;
			 value_2_2_out2<=8'd0;
			 value_2_3_out2<=8'd0;
			 value_3_1_out2<=8'd0;
			 value_3_2_out2<=8'd0;
			 value_3_3_out2<=8'd0;
			 count<=5'd1;
			 finish<=1'b0;
		end
		else
		begin
			if(!start)
			begin
				 value_1_1_out<=(value_1_1>=value_1_2)?value_1_1:value_1_2;
				 value_1_2_out<=(value_1_1>=value_1_2)?value_1_2:value_1_1;
				 value_1_3_out<=(value_1_3>=value_2_1)?value_1_3:value_2_1;
				 value_2_1_out<=(value_1_3>=value_2_1)?value_2_1:value_1_3;
				 value_2_2_out<=(value_2_2>=value_2_3)?value_1_1:value_1_2;
				 value_2_3_out<=(value_2_2>=value_2_3)?value_1_2:value_2_1;
				 value_3_1_out<=(value_3_1>=value_3_2)?value_1_1:value_1_2;
				 value_3_2_out<=(value_3_1>=value_3_2)?value_1_2:value_1_1;
				 value_3_3_out<=value_3_3;
				 count<=9'd0;
				 finish<=1'd0;
			end
			else
			begin
				 value_1_1_out<=(value_1_1_out2>=value_1_2_out2)?value_1_1_out2:value_1_2_out2;
				 value_1_2_out<=(value_1_1_out2>=value_1_2_out2)?value_1_2_out2:value_1_1_out2;
				 value_1_3_out<=(value_1_3_out2>=value_2_1_out2)?value_1_3_out2:value_2_1_out2;
				 value_2_1_out<=(value_1_3_out2>=value_2_1_out2)?value_2_1_out2:value_1_3_out2;
				 value_2_2_out<=(value_2_2_out2>=value_2_3_out2)?value_1_1_out2:value_1_2_out2;
				 value_2_3_out<=(value_2_2_out2>=value_2_3_out2)?value_1_2_out2:value_2_1_out2;
				 value_3_1_out<=(value_3_1_out2>=value_3_2_out2)?value_1_1_out2:value_1_2_out2;
				 value_3_2_out<=(value_3_1_out2>=value_3_2_out2)?value_1_2_out2:value_1_1_out2;
				 value_3_3_out<=value_3_3_out2;
				 count<=count<<1;
				 finish<=(count[8]==1)?1'b1:1'b0;
			end
			 value_1_1_out2<=value_1_1_out;
			 value_1_2_out2<=(value_1_2_out>=value_1_3_out)?value_1_2_out:value_1_3_out;
			 value_1_3_out2<=(value_1_2_out>=value_1_3_out)?value_1_3_out:value_1_2_out;
			 value_2_1_out2<=(value_2_1_out>=value_2_2_out)?value_2_1_out:value_2_2_out;
			 value_2_2_out2<=(value_2_1_out>=value_2_2_out)?value_2_2_out:value_2_1_out;
			 value_2_3_out2<=(value_2_3_out>=value_3_1_out)?value_2_3_out:value_3_1_out;
			 value_3_1_out2<=(value_2_3_out>=value_3_1_out)?value_3_1_out:value_2_3_out;
			 value_3_2_out2<=(value_3_2_out>=value_3_3_out)?value_3_2_out:value_3_3_out;
			 value_3_3_out2<=(value_3_2_out>=value_3_3_out)?value_3_2_out:value_3_2_out;
		end
	
	end
	
	assign value_median=value_2_2_out2;
	
	endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	