module immgen(
    input wire [31:0] instrucao,
    output reg [31:0] imm_out
);

always @(instrucao) begin
    case({instrucao[6:0]})
        7'b0000011: imm_out <= {{21{instrucao[31]}}, instrucao[30:20]}; // Tipo I (lb)
        7'b0100011: imm_out <= {{21{instrucao[31]}}, instrucao[30:25], instrucao[11:7]}; // Tipo S (sb)
        7'b0010011: imm_out <= {{21{instrucao[31]}}, instrucao[30:20]}; // Tipo I (ori)
        7'b1100011: imm_out <= {{20{instrucao[31]}}, instrucao[7], instrucao[30:25], instrucao[11:8], {1{1'b0}}}; // Tipo SB (bne)
        default: imm_out <= 32'bx; // condição básica
    endcase
end

endmodule