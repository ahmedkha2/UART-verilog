module UART_TX #(parameter IN_width = 8) (
  input [IN_width-1:0]       P_DATA,
  input                      DATA_VALID,
  input                      PAR_EN, PAR_TYP,
  input                      CLK, RST,

  output                     TX_OUT,
  output                     busy);

wire ser_done, ser_en, par_bit,ser_data;
wire [1:0] MUX_sel;

FSM fsm (
  .PAR_EN(PAR_EN), .DATA_valid(DATA_VALID), .SER_done(ser_done),
  .CLK(CLK), .RST(RST),
  .SER_EN(ser_en), .MUX_sel(MUX_sel), .busy(busy)
  );

SERIAL serializer (
  .P_DATA(P_DATA), .ser_en(ser_en), .CLK(CLK), .RST(RST),
  .ser_done(ser_done), .ser_data(ser_data)
  );

PAR_CALC parity (
  .P_DATA(P_DATA), .DATA_valid(DATA_VALID), .PAR_TYP(PAR_TYP),
  .CLK(CLK), .RST(RST),
  .par_bit(par_bit)
  );

OUT_MUX mux (
  .MUX_sel(MUX_sel),
  .par_bit(par_bit), .ser_data(ser_data),
  .TX_OUT(TX_OUT)
  );

endmodule
