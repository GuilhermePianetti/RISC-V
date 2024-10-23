module alu(
    input clk,
    input [3:0] control,
    input [31:0] entrada0,
    input [31:0] entrada1,
    output reg [31:0] saida,
    output reg zero
);

    always @(*) begin
        case (control)
            4'b0000: begin // AND
                saida <= entrada0 & entrada1;
                zero <= 0;
            end 
            4'b0001: begin // OR
                saida <= entrada0 | entrada1;
                zero <= 0;
            end  
            4'b0010: begin // ADD
                saida <= entrada0 + entrada1;
                zero <= 0;
            end  
            4'b0110: begin // SUB
                saida <= entrada0 - entrada1;
                zero <= ((entrada0 - entrada1) == 32'b0) ? 1 : 0; // Define zero se saida for 0
            end 
            4'b0100: begin // ADD
                saida <= entrada0 << entrada1;
                zero <= 0;
            end  
            default: begin // Default
                saida <= entrada0;
                zero <= 0;
            end
        endcase
    end

endmodule