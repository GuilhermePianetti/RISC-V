module data_mem(
    input wire clk,
    input wire memwrite,
    input wire memread,
    input wire [31:0] address,
    input wire [31:0] wd,   
    output reg [31:0] rd
);

reg [31:0] memoria [0:63];

//adaptado apenas para instruções LB e SB (sempre operara com um byte)

always @(*) begin
    if (memread == 1) begin
        case (address[1:0])  // Verifica os dois bits menos significativos do endereço para identificar a parte da palavra
            2'b00: rd <= {{24{memoria[address >> 2][31]}}, memoria[address >> 2][31:24]};  // 1º quarto
            2'b01: rd <= {{24{memoria[address >> 2][23]}}, memoria[address >> 2][23:16]};  // 2º quarto
            2'b10: rd <= {{24{memoria[address >> 2][15]}}, memoria[address >> 2][15:8]};   // 3º quarto
            2'b11: rd <= {{24{memoria[address >> 2][7]}},  memoria[address >> 2][7:0]};    // 4º quarto
        endcase
    end
end

always @(negedge clk) begin
    if (memwrite == 1) begin
        case (address[1:0])  // Verifica os dois bits menos significativos do endereço para identificar a parte da palavra
            2'b00: memoria[address >> 2][31:24] <= wd[31:24];  // 1º quarto da palavra
            2'b01: memoria[address >> 2][23:16] <= wd[23:16];  // 2º quarto da palavra
            2'b10: memoria[address >> 2][15:8]  <= wd[15:8];  // 3º quarto da palavra
            2'b11: memoria[address >> 2][7:0]   <= wd[7:0];  // 4º quarto da palavra
        endcase
    end
end

endmodule