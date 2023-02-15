`timescale 1ns/1ps
module UART_TX_tb #(parameter IN_width = 8);
reg [IN_width-1:0]       P_DATA;
reg                      DATA_VALID;
reg                      PAR_EN, PAR_TYP;
reg                      CLK, RST;

wire                     TX_OUT;
wire                     busy;

integer x;
integer cycle = 5;
/////////////////initial////////////////////
initial
begin
// Save Waveform
   $dumpfile("UART_TX_tb.vcd") ;
   $dumpvars;

//initial values
    initialize();

//reset
    reset();

//test cases
///////////////////////////NO-PARITY//////////////////////////
    $display("parity disapled test case");
    P_DATA = 'b11111001;
    @(negedge CLK)
    PAR_EN = 1'b0;
    PAR_TYP = 1'b1;
    #cycle
    DATA_VALID = 1'b1;
    #cycle
    DATA_VALID = 1'b0;
    
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    $display("Expected frame = 0111110011");


///////////////////////////ODD-PARITY//////////////////////////
    @(negedge busy)
    $display("odd parity test case");
    #cycle
    @(negedge CLK)
    PAR_EN = 1'b1;
    PAR_TYP = 1'b1;
    #cycle
    DATA_VALID = 1'b1;
    #cycle
    DATA_VALID = 1'b0;
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    $display("Expected frame = 01111100111");

///////////////////////////EVEN-PARITY//////////////////////////
    @(negedge busy)
    $display("even parity test case");
    #cycle
    @(negedge CLK)
    PAR_EN = 1'b1;
    PAR_TYP = 1'b0;
    #cycle
    DATA_VALID = 1'b1;
    #cycle
    DATA_VALID = 1'b0;
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    #cycle
    $display("bit=%b",TX_OUT);
    $display("Expected frame = 01111100101");

    $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {DATA_VALID,PAR_EN,PAR_TYP,CLK,RST} = 1'b0;
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
UART_TX DUT (.P_DATA(P_DATA), .DATA_VALID(DATA_VALID),
            .PAR_EN(PAR_EN), .CLK(CLK), .RST(RST),
            .PAR_TYP(PAR_TYP), .TX_OUT(TX_OUT),
            .busy(busy));

endmodule
