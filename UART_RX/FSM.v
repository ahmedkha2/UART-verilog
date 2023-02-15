module FSM (
  input               PAR_EN, RX_IN, 
  input [4:0]	      prescale,
  input [3:0]	      bit_cnt,
  input [2:0]	      edge_cnt,
  input               par_err, strt_glitch, stp_err,
  input               CLK, RST,

  output reg          dat_samp_en, enable, deser_en, data_valid,
  output reg          stp_chk_en, strt_chk_en, par_chk_en
);

localparam [2:0]  IDLE 	= 3'b000,
                  START = 3'b001,
                  DATA 	= 3'b010,
                  PAR 	= 3'b011,
                  STOP 	= 3'b100,
                  VALID	= 3'b101;

reg [2:0] C_S, N_S;
reg [2:0] ed = 3'b000; 

always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      C_S <= IDLE;
    else
      C_S <= N_S;
  end

always @ (*) begin
      dat_samp_en = 1'b0;
      enable = 1'b0;
      deser_en = 1'b0;
      data_valid = 1'b0;
      stp_chk_en = 1'b0;
      strt_chk_en = 1'b0;
      par_chk_en = 1'b0;
  if (prescale == 5'b01000) begin
    ed = 3'b111;
  end
  else begin
    ed = 3'b011;
  end
  case (C_S)
    IDLE:begin
      dat_samp_en = 1'b0;
      enable = 1'b0;
      deser_en = 1'b0;
      data_valid = 1'b0;
      stp_chk_en = 1'b0;
      strt_chk_en = 1'b0;
      par_chk_en = 1'b0;
      if (!RX_IN) begin
        strt_chk_en = 1'b1;
        enable = 1'b1;
        dat_samp_en = 1'b1;
        N_S = START;
      end
      else begin
        N_S = IDLE;
      end
    end

    START: begin
      dat_samp_en = 1'b1;
      enable = 1'b1;
      deser_en = 1'b0;
      data_valid = 1'b0;
      stp_chk_en = 1'b0;
      strt_chk_en = 1'b1;
      par_chk_en = 1'b0;
      if(bit_cnt == 4'b0000 && edge_cnt == ed) begin
       if (!strt_glitch) begin 
        N_S = DATA;
       end
       else begin
	N_S = IDLE;
       end
      end
      else begin
       N_S = START;
      end
    end

    DATA: begin
      dat_samp_en = 1'b1;
      data_valid = 1'b0;
      stp_chk_en = 1'b0;
      enable = 1'b1;
      strt_chk_en = 1'b0;
      deser_en = 1'b1;
      par_chk_en = 1'b0;
      if(bit_cnt == 4'b1000 && edge_cnt == ed) begin
       if (PAR_EN) begin
	N_S = PAR;
       end
       else begin
	N_S = STOP;
       end
      end
      else begin
	N_S = DATA;
      end
    end

    PAR: begin
      dat_samp_en = 1'b1;
      data_valid = 1'b0;
      stp_chk_en = 1'b0;
      enable = 1'b1;
      strt_chk_en = 1'b0;
      deser_en = 0;
      par_chk_en = 1'b1;
      if(bit_cnt == 4'b1001 && edge_cnt == ed) begin
       if (!par_err) begin
	N_S = STOP;
       end
       else begin
	N_S = IDLE;
       end
      end
      else begin
       N_S = PAR;
      end    
    end

    STOP: begin
      dat_samp_en = 1'b1;
      data_valid = 1'b0;
      enable = 1'b1;
      strt_chk_en = 1'b0;
      deser_en = 0;
      par_chk_en = 1'b0;
      stp_chk_en = 1'b1;
      if(bit_cnt == 4'b1010 && edge_cnt == ed) begin
       if (!stp_err) begin
	N_S = VALID;
       end
       else begin
	N_S = IDLE;
       end
      end
      else begin
       N_S = STOP;
      end 
    end

    VALID: begin
      strt_chk_en = 1'b0;
      deser_en = 0;
      par_chk_en = 1'b0;
      enable = 1'b0;
      dat_samp_en = 1'b0;
      data_valid = 1'b1;
      stp_chk_en = 1'b0;
      if (!RX_IN) begin
	N_S = START;
      end
      else begin
	N_S = IDLE;
      end
    end

    default: N_S = IDLE;
  endcase
end

endmodule //FSM
