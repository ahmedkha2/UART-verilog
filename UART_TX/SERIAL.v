module SERIAL #(parameter IN_width = 8) (
  input [IN_width-1:0]       P_DATA,
  input                      ser_en,
  input                      CLK,RST,

  output                     ser_done,
  output reg                 ser_data);

/////////////////////////////////////
integer               x;
reg [3:0]             counter = 4'b0000;
reg [IN_width-1:0]    data;

/////////////////////////////////////
always @ (posedge CLK or negedge RST) begin
  if (!RST) begin
    ser_data <= 0;
  end
  else if (counter == 4'b0000 && ser_en) begin
    data <= P_DATA;
    counter <= counter + 1;
  end
  else if (ser_en) begin
    if (counter == 4'b1001) begin
      counter <= 4'b0;
    end
    else begin
      ser_data <= data[7];
      for (x=7; x>0; x=x-1) begin
        data[x] <= data[x-1];
      end
      counter <= counter + 1;
    end
  end
  else begin
    ser_data <= 1'b0;
  end
end

assign ser_done = (counter == 4'b1001);

endmodule //
