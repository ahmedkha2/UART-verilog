`timescale 1ns/1ps
module SERIAL_tb #(parameter IN_width = 8);

reg [IN_width-1:0]       P_DATA;
reg                      ser_en;
reg                      CLK,RST;

wire                     ser_done;
wire                     ser_data;


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
    P_DATA = 'b11001101;
    #3
    ser_en = 1'b1;
    #5
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);
    #5
    $display("bit= %b",ser_data);

    $stop;
end

/////////////////////////////TASKS/////////////////////

task initialize;
  begin
    {ser_en,CLK,RST} = 1'b0;
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
SERIAL DUT (.P_DATA(P_DATA),
            .ser_en(ser_en),
            .CLK(CLK),.RST(RST),
            .ser_done(ser_done),
            .ser_data(ser_data));

endmodule
