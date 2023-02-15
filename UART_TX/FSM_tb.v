`timescale 1ns/1ps
module FSM_tb();

reg               PAR_EN;
reg               DATA_valid;
reg               SER_done;
reg               CLK,RST;

wire          SER_EN;
wire [1:0]    MUX_sel;
wire          busy;


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

//test cases
    PAR_EN = 1'b1;
    DATA_valid = 1'b1;
    SER_done = 1'b0;
    #3
    #2
    PAR_EN = 1'b1;
    DATA_valid = 1'b0;
    SER_done = 1'b0;
    #3
    #2
    #15
    PAR_EN = 1'b1;
    DATA_valid = 1'b0;
    SER_done = 1'b1;
    #3
    #2
    PAR_EN = 1'b1;
    DATA_valid = 1'b0;
    SER_done = 1'b0;
    #3
    $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {PAR_EN,DATA_valid,SER_done,CLK,RST}=1'b0;
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
FSM DUT (.PAR_EN(PAR_EN), .DATA_valid(DATA_valid),
         .SER_done(SER_done), .CLK(CLK), .RST(RST),
         .SER_EN(SER_EN), .MUX_sel(MUX_sel),
         .busy(busy));

endmodule
