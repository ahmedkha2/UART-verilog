module OUT_MUX (
  input [1:0]   MUX_sel,
  input         par_bit,
  input         ser_data,
  output reg    TX_OUT);

localparam [1:0]  stop = 2'b01,
                  start = 2'b00,
                  data = 2'b10,
                  parity = 2'b11;

always @ ( * ) begin
  case (MUX_sel)
    stop: TX_OUT = 1'b1;
    start: TX_OUT = 1'b0;
    data: TX_OUT = ser_data;
    parity: TX_OUT = par_bit;
  endcase
end
endmodule // OUT_MUX
