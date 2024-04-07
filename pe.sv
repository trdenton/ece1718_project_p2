module pe #(parameter BW = 8) (
    input logic i_clock,
    input logic i_reset,
    input logic [BW-1:0] i_activation,
    input logic [BW-1:0] i_weight,
    output logic [(2*BW)-1:0] o_output
);
    reg [BW-1:0] r_weight;
    reg [BW-1:0] r_activation;
    reg [(2*BW)-1:0] acc;
    //reg [(2*BW)-1:0] result;

    logic [(2*BW)-1:0] mult;
    logic [(2*BW)-1:0] add;

    always @(*) begin
       mult = r_activation * r_weight;
       add = mult + acc;
    end

    always @(posedge i_clock, posedge i_reset) begin
        if (i_reset == 1'b1) begin
            acc <= 0;
	    add <= 0;
	    mult <= 0;
	    r_weight <= 0;
	    r_activation <= 0;
        end else begin
            r_weight <= i_weight;
            r_activation <= i_activation;
            acc <= add;
            o_output <= acc;
        end
    end
endmodule
