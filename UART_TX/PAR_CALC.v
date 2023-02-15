module PAR_CALC #(parameter IN_width = 8) (
  input [IN_width-1:0]       P_DATA,
  input                      DATA_valid,
  input                      PAR_TYP,
  input                      CLK,RST,

  output reg                 par_bit);

reg                        par;

always @ (posedge CLK or negedge RST) begin
  if (!RST) begin
    par_bit <= 1'b0;
  end
  else if (DATA_valid) begin
      par <= ^P_DATA;//even or odd data?
  end
  else begin
    if (PAR_TYP) begin //odd parity
      par_bit <= !par;
    end
    else begin
      par_bit <= par;
    end
  end
 
end

endmodule // PAR_CALC
