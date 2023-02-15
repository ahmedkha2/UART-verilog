`timescale 1ns/1ps
module UART_RX_tb;
reg 			PAR_EN, PAR_TYP;
reg 			RX_IN,CLK,RST;
reg [4:0]		prescale;

wire [7:0]		P_DATA;
wire 			data_valid;

integer cycle = 5;
integer data_4 = 20;
integer data_8 = 40;

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

//test case expected data frame = 0100_0110
//4 PRESCALE
PAR_EN = 1'b1;
PAR_TYP = 1'b0;
prescale = 5'b00100;
RX_IN = 1'b0;//start
#data_4
RX_IN = 1'b0;//data0
#data_4
RX_IN = 1'b1;//data1
#data_4
RX_IN = 1'b1;//data3
#data_4
RX_IN = 1'b0;//data4
#data_4
RX_IN = 1'b0;//data5
#data_4
RX_IN = 1'b0;//data6
#data_4
RX_IN = 1'b1;//data7
#data_4
RX_IN = 1'b0;//data8
#data_4
RX_IN = 1'b1;//parity
#data_4
RX_IN = 1'b0;//stop
@(posedge data_valid)
$display("expected frame = 0100_0110, received frame = %b", P_DATA);
#10
//8PRESCALE
reset();
@(negedge CLK)
PAR_EN = 1'b1;
PAR_TYP = 1'b0;
prescale = 5'b01000;
RX_IN = 1'b0;//start
#data_8
RX_IN = 1'b0;//data0
#data_8
RX_IN = 1'b1;//data1
#data_8
RX_IN = 1'b1;//data3
#data_8
RX_IN = 1'b0;//data4
#data_8
RX_IN = 1'b0;//data5
#data_8
RX_IN = 1'b0;//data6
#data_8
RX_IN = 1'b1;//data7
#data_8
RX_IN = 1'b0;//data8
#data_8
RX_IN = 1'b1;//parity
#data_8
RX_IN = 1'b0;//stop
@(posedge data_valid)
$display("expected frame = 0100_0110, received frame = %b", P_DATA);
$stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {PAR_EN,PAR_TYP,CLK,RST} = 1'b0;
    prescale = 5'b0;
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
UART_RX DUT (.PAR_EN(PAR_EN), .PAR_TYP(PAR_TYP),
            .RX_IN(RX_IN), .CLK(CLK), .RST(RST),
            .prescale(prescale), .P_DATA(P_DATA),
            .data_valid(data_valid));

endmodule