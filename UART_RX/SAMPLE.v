module SAMPLE (
 input		RX_IN, dat_samp_en,
 input [2:0]	edge_cnt,
 input [4:0]	prescale,
 input 		CLK,RST,

 output reg 	sampled_bit
);

integer 	x;
reg [2:0]	AVG;

always@(posedge CLK or negedge RST)
begin
 if (!RST) begin
  sampled_bit <= 1'b1;
 end
 else if (dat_samp_en && prescale == 5'b00100 && edge_cnt == 3'b010) begin
  sampled_bit <= RX_IN;
 end
 else if (prescale == 5'b01000 && dat_samp_en) begin
  sampled_bit <= (AVG[0]&AVG[1] | AVG[1]&AVG[2] | AVG[0]&AVG[2]);
 end
 else begin
  sampled_bit <= 1'b1;
 end
end

always@(posedge CLK or negedge RST)
begin
  if(!RST) begin
   AVG <= 3'b0;
  end
  else begin
   if(dat_samp_en) begin
     if(edge_cnt == 3'b011) begin
      AVG[0] <= RX_IN;
     end
     else if(edge_cnt == 3'b100) begin
      AVG[1] <= RX_IN;
     end
     else if(edge_cnt == 3'b101) begin
      AVG[2] <= RX_IN;
     end
   end
   else begin
    AVG <= 3'b0;
   end
  end
end

endmodule 