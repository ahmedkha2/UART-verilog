module DESERIALIZER #(parameter IN_width = 8)(
  input [2:0]		     edge_cnt,
  input 		     sampled_bit,
  input                      deser_en,
  input [4:0]		     prescale,
  input                      CLK,RST,

  output reg [IN_width-1:0]  P_DATA);

/////////////////////////////////////
integer               x;
reg [3:0]             counter = 4'b1000;
reg [IN_width-1:0]    data = 'b0;

/////////////////////////////////////
always @ (posedge CLK or negedge RST) begin
  if (!RST) begin
    P_DATA <= 0;
  end
  else if (deser_en && counter != 4'b0000) begin
    if (prescale == 5'b00100 && edge_cnt == 3'b011) begin
	data[7] <= sampled_bit;
        for (x=6; x>=0; x=x-1) begin
          data[x] <= data[x+1];
        end
        counter <= counter - 1;
    end
    else if (prescale == 5'b01000 && edge_cnt == 3'b111) begin
	data[7] <= sampled_bit;
        for (x=6; x>=0; x=x-1) begin
          data[x] <= data[x+1];
        end
        counter <= counter - 1;
    end
  end
  else if (counter == 4'b0000) begin
  	P_DATA <= data;
	counter <= 4'b1000;
  end
  else begin
  	P_DATA <= P_DATA;
  end
end

endmodule 