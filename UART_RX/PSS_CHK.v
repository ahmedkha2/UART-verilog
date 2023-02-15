module PSS_CHK (
input 		sampled_bit, PAR_TYP,
input [7:0]	P_DATA,
input 		par_chk_en, strt_chk_en, stp_chk_en,

output reg	par_err, strt_glitch, stp_err
);

reg par;

always@(*)
begin
par_err = 1'b0;
strt_glitch = 1'b0;
stp_err = 1'b0;
 if (strt_chk_en) begin
  strt_glitch = (sampled_bit != 0);
 end
 else if (par_chk_en) begin
  par = ^P_DATA;
  if (PAR_TYP) begin
   par_err = (par == sampled_bit);
  end
  else begin
   par_err = (!par == sampled_bit);
  end
 end
 else if (stp_chk_en) begin
  stp_err = (sampled_bit != 0);
 end
 else begin
  {par_err, strt_glitch, stp_err} = 1'b0;
 end
end

endmodule 