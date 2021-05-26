module counter(
	clk,
	rst,
	count,
	clear,
	keep
);
	input               clk;
	input               rst;
	input               keep;
	input               clear;
	output reg        [13:0]   count;
	reg        [13:0]   count_in;
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		
		begin
			count<=14'd0;
		end
		else
		begin
			count<=count_in;
		end

	end
	always@(*)
	begin
		if(clear)
		begin
			count_in=14'd0;
		end
		else if(keep)
		begin
			count_in=count;
		end
		else
		begin
			count_in=count+14'd1;
		end
	end
endmodule