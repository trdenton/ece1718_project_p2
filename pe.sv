module PE #(parameter BW = 8) (
    input logic i_clock,
    input logic i_reset,
    input logic [BW-1:0] i_activation,
    input logic [BW-1:0] i_weight,
    output logic [(2*BW)-1:0] o_output
);
    reg [BW-1:0] r_weight;
    reg [BW-1:0] r_activation;
    reg [(2*BW)-1:0] acc;
    reg [(2*BW)-1:0] result;

    logic [(2*BW)-1:0] mult;
    logic [(2*BW)-1:0] add;

    assign o_output = result;

    always @(*) begin
       mult = r_activation * r_weight;
       add = mult + acc;
    end

    always @(posedge i_clock, posedge i_reset) begin
        if (i_reset == 1'b0) begin
            acc <= 0;
            result <= 0;
        end else begin
            r_weight <= i_weight;
            r_activation <= i_activation;
            acc <= add;
            result <= acc;
        end
    end
endmodule
