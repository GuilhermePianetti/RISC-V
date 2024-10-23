module RISC_V(
    input wire clk, 
    input wire reset,
	 output wire [7:0]saidaPC,
	 output wire [4:0]saida_rr1, 
	 output wire [4:0]saida_rr2,
	 output wire[7:0]saida_rs1, 
	 output wire[7:0]saida_rs2
);

//fios para interligação dos módulos
wire [31:0] PC_InsMem, instrucao, rs0, rs1, aluOut, wd, rd, ALUSrc_saida, imm_out, WriteBack, PC_prox;
wire [3:0] alu_control_out;
wire branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, zero;
wire [1:0] aluop;
wire [31:0] nextIns;
wire [31:0] PCplusImm;
wire branchOrNot;

//descrevendo condições para endereço do PC

assign nextIns = PC_InsMem + 32'h4;
assign branchOrNot = branch & ~zero;
assign PCplusImm = PC_InsMem + imm_out;
assign saidaPC = PC_InsMem[7:0];
assign saida_rr1 = instrucao[19:15];
assign saida_rr2 = instrucao[24:20];
assign saida_rs1 = rs0[7:0];
assign saida_rs2 = rs1[7:0];


// Instanciando módulos

PC PC(
    .reset(reset), 
    .clk(clk),
    .PC_in(PC_prox),
    .PC_out(PC_InsMem)
);

instruction_mem instruction_mem(
	 .clk(clk),
    .endereco(PC_InsMem),
    .instrucao(instrucao)
);

register_bank register_bank(
    .clk(clk),
	 .reset(reset),
    .regwrite(RegWrite),
    .rr0(saida_rr1), 
    .rr1(saida_rr2), 
    .wr(instrucao[11:7]),  
    .wd(WriteBack), 
    .rs0(rs0),
    .rs1(rs1)
);

immgen _immgen(
    .instrucao(instrucao),
    .imm_out(imm_out)
);

alu _alu(
    .clk(clk),
    .control(alu_control_out),
    .entrada0(rs0),
    .entrada1(ALUSrc_saida), 
    .saida(aluOut),
    .zero(zero) 
);

data_mem _data_mem(
    .clk(clk),
    .memwrite(MemWrite), 
    .memread(MemRead), 
    .address(aluOut),
    .wd(rs1),
    .rd(rd)
);

alu_control _alu_control(
    .alu_op(aluop),
    .func7(instrucao[31:25]),
    .func3(instrucao[14:12]),
    .alu_control_out(alu_control_out)
);

control _control(
    .opcode(instrucao[6:0]),
    .branch(branch),
    .MemRead(MemRead), 
    .MemToReg(MemToReg), 
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc), 
    .RegWrite(RegWrite),
    .AluOp(aluop)
);

mux _MuxALUSrc(
    .clk(clk),
    .control(ALUSrc),   
    .entrada0(rs1),
    .entrada1(imm_out), 
    .saida(ALUSrc_saida)     
);

mux _MuxMemToReg(
    .clk(clk),
    .control(MemToReg),   
    .entrada0(aluOut),
    .entrada1(rd), 
    .saida(WriteBack)      
);




mux _MuxBranch(
    .clk(clk),
    .control(branchOrNot),   
    .entrada0(nextIns),
    .entrada1(PCplusImm), 
    .saida(PC_prox)      
);

endmodule