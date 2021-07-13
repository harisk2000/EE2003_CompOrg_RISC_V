module alu32(
    input [5:0] op,                // Some input encoding of choice
    input [31:0] rv1,              // First operand value
    input [31:0] rv2,              // Second operand value
    output reg [31:0] rvout        // Output value
);
    always @(op or rv1 or rv2) begin
        case(op)            
            6'b000000: rvout = rv1 + rv2;                    //ADDI
            6'b000001: rvout = $signed(rv1) < $signed(rv2);  //SLTI
            6'b000010: rvout = rv1 < rv2;                    //SLTIU
            6'b000011: rvout = rv1 ^ rv2;                    //XORI
            6'b000100: rvout = rv1 | rv2;                    //ORI
            6'b000101: rvout = rv1 & rv2;                    //ANDI
            6'b000110: rvout = rv1 << rv2[4:0];              //SLLI
            6'b000111: rvout = rv1 >> rv2[4:0];              //SRLI
            6'b001000: rvout = $signed(rv1) >>> rv2[4:0];    //SRAI
            6'b001001: rvout = rv1 + rv2;                    //ADD
            6'b001010: rvout = rv1 - rv2;                    //SUB
            6'b001011: rvout = rv1 << rv2[4:0];              //SLL
            6'b001100: rvout = $signed(rv1) < $signed(rv2);  //SLT
            6'b001101: rvout = rv1 < rv2;                    //SLTU
            6'b001110: rvout = rv1 ^ rv2;                    //XOR
            6'b001111: rvout = rv1 >> rv2[4:0];              //SRL
            6'b010000: rvout = $signed(rv1) >>> rv2[4:0];    //SRA
            6'b010001: rvout = rv1 | rv2;                    //OR
            6'b010010: rvout = rv1 & rv2;                    //AND
            default: rvout = 0;
  
       endcase
    end

endmodule
