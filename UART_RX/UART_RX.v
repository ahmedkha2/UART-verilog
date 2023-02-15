module UART_RX (
input 			PAR_EN, PAR_TYP,
input 			RX_IN, CLK, RST,
input [4:0]		prescale,

output [7:0]		P_DATA,
output 			data_valid
);

wire 			dat_samp_en, enable, par_chk_en, strt_chk_en, stp_chk_en, deser_en;
wire			par_err, strt_glitch, stp_err, sampled_bit;
wire [3:0]		bit_cnt;
wire [2:0] 		edge_cnt;

FSM fsm (
.PAR_EN(PAR_EN), .RX_IN(RX_IN), .bit_cnt(bit_cnt),
.CLK(CLK), .RST(RST), .prescale(prescale),
.edge_cnt(edge_cnt), .par_err(par_err), .strt_glitch(strt_glitch),
.stp_err(stp_err), .dat_samp_en(dat_samp_en), .enable(enable),
.deser_en(deser_en), .data_valid(data_valid), .stp_chk_en(stp_chk_en),
.strt_chk_en(strt_chk_en), .par_chk_en(par_chk_en)
);

SAMPLE sample (
.RX_IN(RX_IN), .dat_samp_en(dat_samp_en), .edge_cnt(edge_cnt),
.CLK(CLK), .RST(RST),
.prescale(prescale), .sampled_bit(sampled_bit)
);

DESERIALIZER deser (
.sampled_bit(sampled_bit), .deser_en(deser_en), .P_DATA(P_DATA), .prescale(prescale), .edge_cnt(edge_cnt),
.CLK(CLK), .RST(RST)
);

COUNTER counter (
.enable(enable), .prescale(prescale), .bit_cnt(bit_cnt),
.CLK(CLK), .RST(RST),
.edge_cnt(edge_cnt)
);

PSS_CHK check (
.sampled_bit(sampled_bit), .PAR_TYP(PAR_TYP), .P_DATA(P_DATA),
.par_chk_en(par_chk_en), .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), 
.par_err(par_err), .strt_glitch(strt_glitch), .stp_err(stp_err)
);

endmodule 