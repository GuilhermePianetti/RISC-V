module instruction_mem(
	input clk,
    input wire [31:0] endereco,
    output reg [31:0] instrucao
);

    reg [31:0] mem_instruction [0:63];

	always @(posedge clk)begin
		mem_instruction[0] <= 32'b00000000000000001000000110110011;
		mem_instruction[1] <= 32'b00000000000100000000000110100011;
		mem_instruction[2] <= 32'b00000000001100000000000100000011;
		mem_instruction[3] <= 32'b00000000010000001110001100010011;
		mem_instruction[4] <= 32'b00000000000100110111001010110011;
		mem_instruction[5] <= 32'b00000000000100110001001110110011;
		mem_instruction[6] <= 32'b00000000011100001001010001100011;
		mem_instruction[7] <= 32'b00000000000000001000010100110011;
		mem_instruction[8] <= 32'b00000000000000001000010110110011;
		
	end
	
    always @(endereco) begin
		if (endereco === 32'bx) begin
         instrucao = 32'bx;
      end
      else begin
         instrucao = mem_instruction[endereco / 4];
      end
	end

endmodule