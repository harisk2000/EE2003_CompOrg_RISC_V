module cpu (
    input clk,                            // Clock signal - all changes at clock posedge
    input reset,                          // Reset for IMEM and DMEM
    input [31:0] drdata,                  // Data from DMEM
    input [31:0] idata,                   // Instruction data from IMEM
    output reg [31:0] iaddr,              // Next instruction address
    output reg [31:0] daddr,              // Address of data at DMEM to be read or written
    output reg [31:0] dwdata,             // Data to be written at DMEM
    output reg [3:0] dwe                  // Write Enable for DMEM (1-Write, 0-Read)
);  
    
    wire [3:0] d_dwe;                     // Write Enable of DMEM from Decoder to CPU output(dwe)
    wire [4:0] rs1, rs2, rd;              // Source and Destination register address from Decoder to Regfile
    wire [5:0] op;                        // Operation code from Decoder to ALU
    wire [31:0] rv1;                      // First Operand value from Decoder to ALU
    wire [31:0] rv2;                      // Second Operand value from Decoder to ALU
    wire [31:0] r_rv1;                    // First Source register value from RegFile to Decoder
    wire [31:0] r_rv2;                    // Second Source register value from RegFile to Decoder
    wire [31:0] rvout;                    // Output of ALU to CPU output(daddr) and Decoder input(alu_wdata)
    wire [31:0] wdata;                    // Write Data from Decoder to RegFile
    wire [31:0] d_dwdata;                 // DMEM Write data from Decoder to CPU output(dwata)
    wire  we;                             // Decoder to Write Enable of RegFile
    wire  pc_sel;                         // Program Counter Select [Selects b/w Branch(1) and +4(0)]
    
 // Instantiate ALU
    alu32 u1(
        .op(op),                          // Operation code from Decoder
        .rv1(rv1),                        // First Operand value from Decoder
        .rv2(rv2),                        // Second Operand value from Decoder
        .rvout(rvout)                     // Output value to Decoder and DMEM(daddr)
    );
    
// Instantiate RegFile
    regfile u2(
        .clk(clk),                      // Clock signal - all changes at clock posedge
        .rs1(rs1),                      // Address of First Source Register from Decoder
        .rs2(rs2),                      // Address of Second Source Register from Decoder
        .rd(rd),                        // Address of Destination Register from Decoder
        .wdata(wdata),                  // Write Data from Decoder
        .we(we),                        // Write Enable from Decoder
        .rv1(r_rv1),                    // Value of First Source Register to Decoder for selecting between this and Program counter
        .rv2(r_rv2)                     // Value of Second Source Register to Decoder for selecting between this and Immediate value
    );

// Instantiate DummyDecoder
    dummydecoder u3(
        .instr(idata),                  // Full bit instruction from IMEM
        .r_rv1(r_rv1),                  // Value of First source register from RegFile
        .r_rv2(r_rv2),                  // Value of Second source register from RegFile
        .iaddr(iaddr),                  // From iaddr register
        .alu_wdata(rvout),              // Output value from ALU
        .drdata(drdata),                // Data from DMEM
        .op(op),                        // Operation code to ALU
        .rv1(rv1),                      // First Operand value to ALU
        .rv2(rv2),                      // Second Operand value to ALU
        .rs1(rs1),                      // First source register address to RegFile
        .rs2(rs2),                      // Second source register address to RegFile
        .rd(rd),                        // Destination register address to RegFile
        .we(we),                        // Write Enable to RegFile
        .wdata(wdata),                  // Write data to RegFile
        .dwe(d_dwe),                    // Write Enable to DMEM
        .dwdata(d_dwdata),              // Write data to DMEM      
        .pc_sel(pc_sel)                 // Select b/w +4 and Branch               
    );

    always @(posedge clk) begin
        if (reset) begin                // Resetting IMEM and DMEM
            iaddr <= 0;
            daddr <= 0;
            dwdata <= 0;
            dwe <= 0;
        end else if(pc_sel) begin 
            iaddr <= rvout;             // Next Instruction address when branching(pc_sel=1)
        end else begin
            iaddr <= iaddr + 4;         // Next Instruction address during normal flow(pc_sel=0)
        end
    end
    
     // Updating CPU outputs from Decoder and ALU 
    always @(d_dwe or d_dwdata or rvout) begin
        dwe = d_dwe;
        dwdata = d_dwdata;
        daddr = rvout;
    end
    

endmodule