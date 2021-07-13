module dummydecoder(
    input [31:0] instr,  // Full 32-b instruction
    output [5:0] op,     // some operation encoding of your choice
    output [4:0] rs1,    // First operand
    output [4:0] rs2,    // Second operand
    output [4:0] rd,     // Output reg
    input  [31:0] r_rv2, // From RegFile
    output [31:0] rv2,   // To ALU
    output we            // Write to reg
);

    assign op = 'h0;
    assign rs1 = 'h0;
    assign rs2 = 'h0;
    assign rd = 'h0;
    assign we = 1;      // For only ALU ops, can always set to 1
    assign rv2 = 'h0;   // Should send either the value from the RegFile or the Imm value from Instr

endmodule
