module FSM (
  input               PAR_EN,
  input               DATA_valid,
  input               SER_done,
  input               CLK,RST,

  output reg          SER_EN,
  output reg [1:0]    MUX_sel,
  output reg          busy
);

localparam [2:0]  IDLE = 3'b000,
                  START = 3'b001,
                  DATA = 3'b010,
                  PAR = 3'b011,
                  STOP = 3'b100;

reg [3:0] C_S, N_S;

always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      C_S <= IDLE;
    else
      C_S <= N_S;
  end

always @ (*) begin
  case (C_S)
    IDLE:begin
      SER_EN = 1'b0;
      MUX_sel  = 2'b01;
      busy  = 1'b0;
      if (DATA_valid) begin
        SER_EN = 1'b1;
        N_S = START;
      end
      else begin
        N_S = IDLE;
      end
    end

    START: begin
      MUX_sel  = 2'b00;
      busy  = 1'b1;
      N_S = DATA;
    end

    DATA: begin
      if (!SER_done) begin
        SER_EN = 1'b1;
        MUX_sel  = 2'b10;
        busy  = 1'b1;
      end
      else if (SER_done && PAR_EN) begin
        N_S = PAR;
      end
      else if (SER_done && !PAR_EN) begin
        N_S = STOP;
      end
      else begin
        N_S = IDLE;
      end
    end

    PAR: begin
      SER_EN = 1'b0;
      MUX_sel  = 2'b11;
      busy  = 1'b1;
      N_S = STOP;
    end

    STOP: begin
      SER_EN = 1'b0;
      MUX_sel  = 2'b01;
      busy  = 1'b1;
      N_S = IDLE;
    end

    default: N_S = IDLE;
  endcase
end

endmodule //FSM
