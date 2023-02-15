module COUNTER (
  input 		enable, CLK, RST,
  input  [4:0]		prescale,
  output reg [3:0]	bit_cnt,
  output reg [2:0]	edge_cnt
);

always@(posedge CLK or negedge RST)
  begin
    if(!RST) begin
	bit_cnt <= 2'b00;
	edge_cnt <= 3'b000;
    end
    else if (prescale == 5'b00100 && enable) begin //4 prescale
	if (edge_cnt == 3'b011) begin
	  edge_cnt <= 3'b000;
	  bit_cnt <= bit_cnt + 1; 
	end
	else begin
	  edge_cnt <= edge_cnt + 1;
	end
    end	
    else if (prescale == 5'b01000 && enable) begin //8 prescale
	if (edge_cnt == 3'b111) begin
	  edge_cnt <= 3'b000;
	  bit_cnt <= bit_cnt + 1; 
	end
	else begin
	  edge_cnt <= edge_cnt + 1;
	end
    end	
    else begin
	bit_cnt <= 4'b0000;
	edge_cnt <= 3'b000;
    end
  end
endmodule
