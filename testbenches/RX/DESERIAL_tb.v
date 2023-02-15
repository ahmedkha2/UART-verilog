`timescale 1ns/1ps
module DESERIAL_tb #(parameter IN_width = 8);

reg [2:0]	  	edge_cnt;
reg 		     	sampled_bit;
reg                     deser_en;
reg [4:0]		prescale;
reg                     CLK,RST;

wire [IN_width-1:0]  	P_DATA;


/////////////////initial////////////////////
initial
begin
// Save Waveform
   $dumpfile("SERIAL_tb.vcd") ;
   $dumpvars;

//initial values
    initialize();

//reset
    reset();

//test cases
    @(negedge CLK)
    deser_en = 1'b1;
prescale = 5'b01000;
edge_cnt = 3'b111;
    sampled_bit = 1'b1;
    @(negedge CLK)
    sampled_bit = 1'b0;
    @(negedge CLK)
    sampled_bit = 1'b1;
    @(negedge CLK)
    sampled_bit = 1'b1;
    @(negedge CLK)
    sampled_bit = 1'b1;
    @(negedge CLK)
    sampled_bit = 1'b0;
    @(negedge CLK)
    sampled_bit = 1'b0;
    @(negedge CLK)
    sampled_bit = 1'b1;
    #10
    @(negedge CLK)
    $display("captured frame = %b",P_DATA);
    $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {sampled_bit,deser_en,CLK,RST} = 1'b0;
prescale = 5'b00000;
edge_cnt = 3'b00;
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
DESERIALIZER DUT (.sampled_bit(sampled_bit),
            .deser_en(deser_en),
            .CLK(CLK),.RST(RST),
            .P_DATA(P_DATA),.prescale(prescale),.edge_cnt(edge_cnt));

endmodule 