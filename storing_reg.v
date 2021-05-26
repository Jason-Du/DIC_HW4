module storing_reg(
clk,
rst,
start,
start_addr,
data_in,

value_1_1,
value_1_2,
value_1_3,
value_2_1,
value_2_2,
value_2_3,
value_3_1,
value_3_2,
value_3_3,
finish,
addr
);
input clk;
input rst;
input start;
input  [13:0] start_addr;
input  [7:0] data_in;
output [7:0] value_1_1;
output [7:0] value_1_2;
output [7:0] value_1_3;
output [7:0] value_2_1;
output [7:0] value_2_2;
output [7:0] value_2_3;
output [7:0] value_3_1;
output [7:0] value_3_2;
output [7:0] value_3_3;
output finish;

output [13:0] addr;


wire [7:0] row_1;
wire [7:0] col_1;
wire [7:0] row_2;
wire [7:0] col_2;
wire [7:0] row_3;
wire [7:0] col_3;
wire [15:0] get_1_1_addr;
wire [15:0] get_1_2_addr;
wire [15:0] get_1_3_addr;
wire [15:0] get_2_1_addr;
wire [15:0] get_2_2_addr;
wire [15:0] get_2_3_addr;
wire [15:0] get_3_1_addr;
wire [15:0] get_3_2_addr;
wire [15:0] get_3_3_addr;

reg [7:0] localreg_in [8:0];
reg [7:0] localreg_out [8:0];
reg [7:0] col_;
reg [7:0] row_;
reg [3:0] CS;
reg [3:0] NS;
integer i;
always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		for(i=0;i<9;i=i+1)
		begin
			localreg_out[i]<=8'd0;
		end
	end
	else
	begin
		for(i=0;i<9;i=i+1)
		begin
			localreg_out[i]<=localreg_in[i];
		end
	end

end
always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		CS<=4'd0;
	end
	else
	begin
		CS<=NS;
	end
end

localparam IDLE   =4'b0000;
localparam POINT_1=4'b0001;
localparam POINT_2=4'b0010;
localparam POINT_3=4'b0011;
localparam POINT_4=4'b0100;
localparam POINT_5=4'b0101;
localparam POINT_6=4'b0110;
localparam POINT_7=4'b0111;
localparam POINT_8=4'b1000;
localparam POINT_9=4'b1001;
localparam LAST   =4'b1010;
assign row_1={1'b0,start_addr[13:7]};
assign col_1={1'b0,start_addr[6:0]};

assign row_2={1'b0,start_addr[13:7]}+8'd1;
assign col_2={1'b0,start_addr[6:0]}+8'd1;
assign row_3={1'b0,start_addr[13:7]}+8'd2;
assign col_3={1'b0,start_addr[6:0]}+8'd2;

assign get_1_1_addr={row_1,col_1};
assign get_1_2_addr={row_1,col_2};
assign get_1_3_addr={row_1,col_3};
assign get_2_1_addr={row_2,col_1};
assign get_2_2_addr={row_2,col_2};
assign get_2_3_addr={row_2,col_3};
assign get_3_1_addr={row_3,col_1};
assign get_3_2_addr={row_3,col_2};
assign get_3_3_addr={row_3,col_3};


assign addr={row_[6:0],col_[6:0]};

assign finish=(CS==LAST)?1'b1:1'b0;
always@(*)
begin
	for(i=0;i<8;i=i+1)
	begin
		localreg_in[i+1]=localreg_out[i];
	end
	case(CS)
		IDLE:
		begin
			NS  =start?POINT_1:IDLE;
			row_=8'd0;
			col_=8'd0;
			//addr=start?start_addr:8'd0;
			localreg_in[0]=8'd0;
		end
		POINT_1:
		begin
			NS=POINT_2;
			row_=get_1_1_addr[15:8]-8'd1;
			col_=get_1_1_addr[7:0]-8'd1;
			localreg_in[0]=(get_1_1_addr[7:0]==8'd0||get_1_1_addr[15:8]==8'd0||get_1_1_addr[7:0]==8'd129||get_1_1_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_2:
		begin
			NS=POINT_3;
			row_=get_1_2_addr[15:8]-8'd1;
			col_=get_1_2_addr[7:0]-8'd1;
			localreg_in[0]=(get_1_2_addr[7:0]==8'd0||get_1_2_addr[15:8]==8'd0||get_1_2_addr[7:0]==8'd129||get_1_2_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_3:
		begin
			NS=POINT_4;
			row_=get_1_3_addr[15:8]-8'd1;
			col_=get_1_3_addr[7:0]-8'd1;
			localreg_in[0]=(get_1_3_addr[7:0]==8'd0||get_1_3_addr[15:8]==8'd0||get_1_3_addr[7:0]==8'd129||get_1_3_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_4:
		begin
			NS=POINT_5;
			row_=get_2_1_addr[15:8]-8'd1;
			col_=get_2_1_addr[7:0]-8'd1;
			localreg_in[0]=(get_2_1_addr[7:0]==8'd0||get_2_1_addr[15:8]==8'd0||get_2_1_addr[7:0]==8'd129||get_2_1_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_5:
		begin
			NS=POINT_6;
			row_=get_2_2_addr[15:8]-8'd1;
			col_=get_2_2_addr[7:0]-8'd1;
			localreg_in[0]=(get_2_2_addr[7:0]==8'd0||get_2_2_addr[15:8]==8'd0||get_2_2_addr[7:0]==8'd129||get_2_2_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_6:
		begin
			NS=POINT_7;
			row_=get_2_3_addr[15:8]-8'd1;
			col_=get_2_3_addr[7:0]-8'd1;
			localreg_in[0]=(get_2_3_addr[7:0]==8'd0||get_2_3_addr[15:8]==8'd0||get_2_3_addr[7:0]==8'd129||get_2_3_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_7:
		begin
			NS=POINT_8;
			row_=get_3_1_addr[15:8]-8'd1;
			col_=get_3_1_addr[7:0]-8'd1;
			localreg_in[0]=(get_3_1_addr[7:0]==8'd0||get_3_1_addr[15:8]==8'd0||get_3_1_addr[7:0]==8'd129||get_3_1_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_8:
		begin
			NS=POINT_9;
			row_=get_3_2_addr[15:8]-8'd1;
			col_=get_3_2_addr[7:0]-8'd1;
			localreg_in[0]=(get_3_2_addr[7:0]==8'd0||get_3_2_addr[15:8]==8'd0||get_3_2_addr[7:0]==8'd129||get_3_2_addr[15:8]==8'd129)?8'd0:data_in;
		end
		POINT_9:
		begin
			NS=LAST;
			row_=get_3_3_addr[15:8]-8'd1;
			col_=get_3_3_addr[7:0]-8'd1;
			localreg_in[0]=(get_3_3_addr[7:0]==8'd0||get_3_3_addr[15:8]==8'd0||get_3_3_addr[7:0]==8'd129||get_3_3_addr[15:8]==8'd129)?8'd0:data_in;
		end
		LAST:
		begin
			NS=IDLE;
			row_=8'd0;
			col_=8'd0;
			localreg_in[0]=localreg_out[8];
		end
		default
		begin
			NS=IDLE;
			row_=8'd0;
			col_=8'd0;
			localreg_in[0]=8'd0;
		end
	endcase
end

assign value_1_1=localreg_out[0];
assign value_1_2=localreg_out[1];
assign value_1_3=localreg_out[2];
assign value_2_1=localreg_out[3];
assign value_2_2=localreg_out[4];
assign value_2_3=localreg_out[5];
assign value_3_1=localreg_out[6];
assign value_3_2=localreg_out[7];
assign value_3_3=localreg_out[8];

endmodule 
	
