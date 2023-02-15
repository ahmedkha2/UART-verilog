`timescale 1ns/1ps
module FSM_tb();

  reg               PAR_EN, RX_IN;
  reg [3:0]	    bit_cnt;
  reg [2:0]	    edge_cnt;
  reg               par_err, strt_glitch, stp_err;
  reg               CLK, RST;

  wire         	    dat_samp_en, enable, deser_en, data_valid;
  wire         	    stp_chk_en, strt_chk_en, par_chk_en;


/////////////////initial////////////////////
initial
begin
// Save Waveform
   $dumpfile("FSM_tb.vcd") ;
   $dumpvars;

//initial values
    initialize();

//reset
    reset();

//test cases //frame = 0_1111_1111_0_0
 RX_IN  	= 1'b0;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b0000;
 edge_cnt	= 3'b000;
#5//start
 RX_IN  	= 1'b0;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b0000;
 edge_cnt	= 3'b110;
#5//start 
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b0000;
 edge_cnt	= 3'b111;
#5//data
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b0100;
 edge_cnt	= 3'b111;
#5
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1000;
 edge_cnt	= 3'b101;
#5
 RX_IN  	= 1'b0;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1000;
 edge_cnt	= 3'b111;
#5
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1001;
 edge_cnt	= 3'b101;
#5
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1001;
 edge_cnt	= 3'b111;
#5//stop
 RX_IN  	= 1'b0;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1001;
 edge_cnt	= 3'b111;
#5//stop
 RX_IN  	= 1'b0;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1010;
 edge_cnt	= 3'b111;
#5//valid
 RX_IN  	= 1'b1;
 PAR_EN 	= 1'b0;
 par_err 	= 1'b0;
 strt_glitch 	= 1'b0;
 stp_err	= 1'b0;
 bit_cnt	= 4'b1001;
 edge_cnt	= 3'b101;
#10

 $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {PAR_EN, par_err, strt_glitch, stp_err,edge_cnt,bit_cnt,CLK,RST}=1'b0;
    RX_IN = 1'b1;
  end
endtask

task reset;
  begin
    RST = 1'b1;
    #1
    RST = 1'b0;
    #1
    RST = 1'b1;
  end
endtask


///////////////////////Clock Generator////////////////
always begin
        #3
        CLK = !CLK ;
        #2
        CLK = !CLK ;
       end

//instantiation////////////////////////////////////////
FSM DUT (.PAR_EN(PAR_EN), .RX_IN(RX_IN),
         .bit_cnt(bit_cnt), .CLK(CLK), .RST(RST),
         .edge_cnt(edge_cnt), .par_err(par_err),
         .strt_glitch(strt_glitch),.stp_err(stp_err),.dat_samp_en(dat_samp_en),
	 .enable(enable),.deser_en(deser_en),.data_valid(data_valid),
	 .stp_chk_en(stp_chk_en),.strt_chk_en(strt_chk_en),.par_chk_en(par_chk_en));

endmodule
