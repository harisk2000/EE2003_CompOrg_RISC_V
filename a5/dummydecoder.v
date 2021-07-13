module dummydecoder(
    input [31:0] instr,           // Full 32-bit instruction
    input [31:0] r_rv2,           // Value of Second source register from RegFile
    input [31:0] drdata,          // Data from DMEM
    input [31:0] alu_wdata,       // Output value from ALU
    output [4:0] rs1,             // First source register address
    output [4:0] rs2,             // Second source register address
    output [4:0] rd,              // Destination register address
    output reg [5:0] op,          // Operation encoding [accords to alu32 module]
    output reg [31:0] rv2,        // Second Operand value to ALU
    output reg we,                // Write Enable to RegFile
    output reg [3:0] dwe,         // DMEM write Enable
    output reg [31:0] dwdata,     // Data from register to be written to DMEM (Store)
    output reg [31:0] wdata       // Data to be written in RegFile
);

    always @(instr or r_rv2 or drdata or alu_wdata) begin
        case(instr[6:0])
            //  Register-Immediate Instructions
            7'b0010011: begin
                        rv2 = {{20{instr[31]}},instr[31:20]};   // Second operand value = Immediate (Sign-extended to 32-bits)
                        we = 1;                                 // RegFile Write enabled
                        dwe = 0;                                // DMEM Read mode
                        dwdata = 0;                             // DMEM write data empty 
                        wdata = alu_wdata;                      // RegFile Write data = Output from ALU
                        case(instr[14:12])
                            3'b000: op = 6'b000000;                       //ADDI
                            3'b010: op = 6'b000001;                       //SLTI
                            3'b011: op = 6'b000010;                       //SLTIU
                            3'b100: op = 6'b000011;                       //XORI
                            3'b110: op = 6'b000100;                       //ORI
                            3'b111: op = 6'b000101;                       //ANDI
                            3'b001: op = 6'b000110;                       //SLLI
                            3'b101: begin
                                    case(instr[31:25])
                                        7'b0000000: op = 6'b000111;       //SRLI
                                        7'b0100000: op = 6'b001000;       //SRAI
                                    endcase
                                    end
                        endcase
                        end
            
            // Register-Register Instructions
            7'b0110011: begin
                        rv2 = r_rv2;                            // Second operand value = Second source register value
                        we = 1;                                 // RegFile Write enabled
                        dwe = 0;                                // DMEM Read mode
                        dwdata = 0;                             // DMEM write data empty 
                        wdata = alu_wdata;                      // RegFile Write data = Output from ALU
                        case(instr[14:12])
                            3'b000: begin
                                    case(instr[31:25])
                                        7'b0000000: op = 6'b001001;       //ADD
                                        7'b0100000: op = 6'b001010;       //SUB
                                    endcase
                                    end
                            3'b001: op = 6'b001011;                       //SLL
                            3'b010: op = 6'b001100;                       //SLT
                            3'b011: op = 6'b001101;                       //SLTU
                            3'b100: op = 6'b001110;                       //XOR
                            3'b101: begin
                                    case(instr[31:25])
                                        7'b0000000: op = 6'b001111;       //SRL
                                        7'b0100000: op = 6'b010000;       //SRA
                                    endcase
                                    end
                            3'b110: op = 6'b010001;                       //OR
                            3'b111: op = 6'b010010;                       //AND
                        endcase
                        end
            
            // Load Instructions
            7'b0000011: begin
                        rv2 = {{20{instr[31]}},instr[31:20]};              // Second operand value = Immediate (Sign-extended to 32-bits) 
                        we = 1;                                            // RegFile Write enabled
                        dwe = 0;                                           // DMEM Read mode
                        dwdata = 0;                                        // DMEM write data empty 
                        op = 6'b000000;                                    // Operation ADD
                        case(instr[14:12])
                            3'b000: wdata = {{24{drdata[7]}}, drdata[7:0]};              //LB
                            3'b001: wdata = {{16{drdata[15]}}, drdata[15:0]};            //LH
                            3'b010: wdata = drdata;                                      //LW
                            3'b100: wdata = {{24{1'b0}}, drdata[7:0]};                   //LBU
                            3'b101: wdata = {{16{1'b0}}, drdata[15:0]};                  //LHU
                        endcase
                        end
            
            // Store Instructions
            7'b0100011: begin
                        rv2 = {{20{instr[31]}},instr[31:25],instr[11:7]};  // Second operand value = Immediate (Sign-extended to 32-bits) 
                        dwdata = r_rv2;                                    // DMEM write data = Second source register value
                        we = 0;                                            // RegFile Read mode
                        op = 6'b000000;                                    // Operation ADD
                        case(instr[14:12])
                            3'b000: begin                                                //SB
                                    case(alu_wdata[1:0])
                                        2'b00: dwe = 4'b0001;
                                        2'b01: dwe = 4'b0010;
                                        2'b10: dwe = 4'b0100;
                                        2'b11: dwe = 4'b1000;
                                    endcase
                                    end
                            3'b001: begin                                                //SH
                                    case(alu_wdata[1:0])
                                        2'b00: dwe = 4'b0011;
                                        2'b10: dwe = 4'b1100;
                                    endcase
                                    end
                            3'b010: dwe = 4'b1111;                                       //SW
                        endcase
                        end          
        endcase
        end
      assign rs2 = instr[24:20];
      assign rs1 = instr[19:15];
      assign rd = instr[11:7];
   
endmodule
