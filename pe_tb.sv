`timescale 1ns / 1ps
module tb();
    reg clk;
    reg reset;
    reg [7:0] act8;
    reg [7:0] weight8;
    reg [15:0] result;

    PE #(.BW(8)) dut(.i_clock(clk), .i_reset(reset), .i_activation(act8), .i_weight(weight8), .o_output(result));

    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #2
        reset = 1'b0;
    end

    initial begin
	$dumpfile("out.vcd");
	$dumpvars(0, dut);

	// should see output 0,1,2,3... 
        act8=8'd1;
        weight8=8'd1;
        #12

	// reset.  should see output 0,128
	reset = 1'b1;
	act8 = 8'd128;
	weight8 = 8'd1;
	#2
	reset = 1'b0;
	#2		// 1x128
	weight8=8'd2;
	#2		// + 2x128
	weight8=8'd3;
	#2		// + 3x128
	weight8=8'd0;
	#6		// we should get 6x128 = 768
        $finish;
    end

endmodule
