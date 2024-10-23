module alu_control(
    input wire [1:0] alu_op,
    input wire [6:0] func7,
    input wire [2:0] func3,
    output reg [3:0] alu_control_out
);

always @(*) begin
    casez ({alu_op, func7, func3}) // usa casez para permitir 'z' ou 'x'
        12'b00_???????_???: alu_control_out = 4'b0010;  // ADD (LB/SB)
        12'b01_???????_???: alu_control_out = 4'b0110;  // SUB (Branch)
        12'b10_0000000_000: alu_control_out = 4'b0010;  // ADD (R-type)
        12'b10_0100000_000: alu_control_out = 4'b0110;  // SUB (R-type)
        12'b10_0000000_111: alu_control_out = 4'b0000;  // AND (R-type)
        12'b10_???????_110: alu_control_out = 4'b0001;  // OR (R-type)
        12'b10_0000000_001: alu_control_out = 4'b0100;  // SLL (R-type)
        default: alu_control_out = 4'b0000;  // default
    endcase
end

endmodule