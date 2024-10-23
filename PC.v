module PC(
    input wire reset, clk,
    input wire [31:0]PC_in,
    output reg [31:0]PC_out
);

always @(posedge clk) begin
    if (reset) begin
        PC_out <= 32'h00000000;

    end
    else PC_out <= PC_in;
        
end

endmodule