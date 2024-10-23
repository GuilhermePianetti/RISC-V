module control(
    input wire [6:0]opcode,
    output reg branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0]AluOp
);

always @(opcode) begin      //pg 280
    case (opcode)
        7'b0110011:begin   //tipo r
          branch <=0;
          MemRead <=0;
          MemToReg <= 0;
          MemWrite <= 0;
          ALUSrc <= 0;
          RegWrite <=1;
          AluOp <= 2'b10;
        end 
        7'b0010011:begin   //tipo i
          branch <=0;
          MemRead <=0;
          MemToReg <= 0;
          MemWrite <= 0;
          ALUSrc <= 1;
          RegWrite <=1;
          AluOp <= 2'b10;
        end 
        7'b0000011:begin   // lb
          branch <=0;
          MemRead <=1;
          MemToReg <= 1;
          MemWrite <= 0;
          ALUSrc <= 0;
          RegWrite <=1;
          AluOp <= 2'b00;
        end 
        7'b0100011:begin  //sb   foi alterado
          branch <=0;
          MemRead <=0;
          MemToReg <= 0;
          MemWrite <= 1;
          ALUSrc <= 1;
          RegWrite <=0;
          AluOp <= 2'b00;
        end 
        7'b1100011:begin  //bne
          branch <=1;
          MemRead <=0;
          MemToReg <= 0;
          MemWrite <= 0;
          ALUSrc <= 0;
          RegWrite <=0;
          AluOp <= 2'b01;
        end 
    endcase
end

endmodule