module mux (
  input wire clk,              // Declaração do sinal de clock como entrada
  input wire control,          // Declaração do sinal de controle como entrada
  input wire [31:0] entrada0,  // Declaração da entrada0 como entrada de 32 bits
  input wire [31:0] entrada1,  // Declaração da entrada1 como entrada de 32 bits
  output reg [31:0] saida      // Declaração da saída como saída de 32 bits
);

always @(*) begin
    saida = (control == 1'b0) ? entrada0 : entrada1;
end

endmodule