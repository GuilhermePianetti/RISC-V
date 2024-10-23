module register_bank(
    input wire clk,reset,
    input wire regwrite,
    input wire [4:0] rr0, //entrada 1
    input wire [4:0] rr1, //entrada 2
    input wire [4:0] wr,  // registrador de destino
    input wire [31:0] wd, // writeBack (conteudo a ser escrito)
    output reg [31:0] rs0,
    output reg [31:0] rs1
);

    reg [31:0] register [0:31];

    always @(posedge clk or posedge reset) begin
		 
		 if (reset) begin
            register[0] <= 32'b0;
            register[1] <= 32'b0000000000000000000000000000011;
            register[2] <= 32'b0;
            register[3] <= 32'b0;
            register[4] <= 32'b0;
            register[5] = 32'b0;
            register[6] = 32'b0;
            register[7] = 32'b0;
            register[8] = 32'b0;
            register[9] = 32'b0;
            register[10] = 32'b0;
            register[11] = 32'b0;
            register[12] = 32'b0;
            register[13] = 32'b0;
            register[15] = 32'b0;
            register[16] = 32'b0;
            register[17] = 32'b0;
            register[18] = 32'b0;
            register[19] = 32'b0;
            register[20] = 32'b0;
            register[21] = 32'b0;
            register[22] = 32'b0;
            register[23] = 32'b0;
            register[24] = 32'b0;
            register[25] = 32'b0;
            register[26] = 32'b0;
            register[27] = 32'b0;
            register[28] = 32'b0;
            register[29] = 32'b0;
            register[30] = 32'b0;
            register[31] = 32'b0;
        end
		  else if (regwrite == 1 && wr != 0) begin // Evita escrita em register[0]
            register[wr] <= wd;
        end
		 
    end
	 always @(rr0, register[rr0])begin
		rs0 = register[rr0]; 
	 end
	 
	 always @(rr1, register[rr1])begin
		rs1 = register[rr1]; 
	 end
    
endmodule