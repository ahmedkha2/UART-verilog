`timescale 1ns/1ps
module PAR_CALC_tb #(parameter IN_width = 8);

reg [IN_width-1:0]       P_DATA;
reg                      DATA_valid;
reg                      PAR_TYP;
reg                      CLK,RST;

wire                     par_bit;


/////////////////initial////////////////////
initial
begin
// Save Waveform
   $dumpfile("PAR_CALC_tb.vcd") ;
   $dumpvars;

//initial values
    initialize();

//reset
    reset();

//test cases
    P_DATA = 'b11001100;
    #3
    PAR_TYP = 1'b0;
    #5
    DATA_valid = 1'b1;
    #5
    DATA_valid = 1'b0;
    #10
    $display("parity bit = %b",par_bit);

    P_DATA = 'b01001100;
    #3
    PAR_TYP = 1'b0;
    #5
    DATA_valid = 1'b1;
    #5
    DATA_valid = 1'b0;
    #10
    $display("parity bit = %b",par_bit);

    P_DATA = 'b11001100;
    #3
    PAR_TYP = 1'b1;
    #5
    DATA_valid = 1'b1;
    #5
    DATA_valid = 1'b0;
    #10
    $display("parity bit = %b",par_bit);

    P_DATA = 'b10001100;
    #3
    PAR_TYP = 1'b1;
    #5
    DATA_valid = 1'b1;
    #5
    DATA_valid = 1'b0;
    #10
    $display("parity bit = %b",par_bit);

    $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {DATA_valid,PAR_TYP,CLK,RST} = 1'b0;
    P_DATA = 'b0;
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
PAR_CALC DUT (.P_DATA(P_DATA),
              .DATA_valid(DATA_valid),
              .CLK(CLK),.RST(RST),
              .PAR_TYP(PAR_TYP),
              .par_bit(par_bit));

endmodule
