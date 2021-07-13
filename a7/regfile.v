module regfile(
    input [4:0] rs1,           // Address of First Source Register to read (5 bits)
    input [4:0] rs2,           // Address of Second Source Register to read
    input [4:0] rd,            // Address of Destination Register to write
    input we,                  // Write Enable
    input [31:0] wdata,        // Write Data from Decoder to be written
    output reg [31:0] rv1,     // Value of First Source Register
    output reg [31:0] rv2,     // Value of Second Source Register
    input clk                  // Clock signal - all changes at clock posedge
);
    reg [31:0] x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;
    initial begin
        x0 <= 0;
        x1 <= 0;
        x2 <= 0;
        x3 <= 0;
        x4 <= 0;
        x5 <= 0;
        x6 <= 0;
        x7 <= 0;
        x8 <= 0;
        x9 <= 0;
        x10 <= 0;
        x11 <= 0;
        x12 <= 0;
        x13 <= 0;
        x14 <= 0;
        x15 <= 0;
        x16 <= 0;
        x17 <= 0;
        x18 <= 0;
        x19 <= 0;
        x20 <= 0;
        x21 <= 0;
        x22 <= 0;
        x23 <= 0;
        x24 <= 0;
        x25 <= 0;
        x26 <= 0;
        x27 <= 0;
        x28 <= 0;
        x29 <= 0;
        x30 <= 0;
        x31 <= 0;      
    end
    
    // rv1, rv2 are combinational outputs - they will update whenever rs1, rs2 change
    always @(rs1 or rs2) begin
        case(rs1)
            5'b00000: rv1 <= x0;
            5'b00001: rv1 <= x1;
            5'b00010: rv1 <= x2;
            5'b00011: rv1 <= x3;
            5'b00100: rv1 <= x4;
            5'b00101: rv1 <= x5;
            5'b00110: rv1 <= x6;
            5'b00111: rv1 <= x7;
            5'b01000: rv1 <= x8;
            5'b01001: rv1 <= x9;
            5'b01010: rv1 <= x10;
            5'b01011: rv1 <= x11;
            5'b01100: rv1 <= x12;
            5'b01101: rv1 <= x13;
            5'b01110: rv1 <= x14;
            5'b01111: rv1 <= x15;
            5'b10000: rv1 <= x16;
            5'b10001: rv1 <= x17;
            5'b10010: rv1 <= x18;
            5'b10011: rv1 <= x19;
            5'b10100: rv1 <= x20;
            5'b10101: rv1 <= x21;
            5'b10110: rv1 <= x22;
            5'b10111: rv1 <= x23;
            5'b11000: rv1 <= x24;
            5'b11001: rv1 <= x25;
            5'b11010: rv1 <= x26;
            5'b11011: rv1 <= x27;
            5'b11100: rv1 <= x28;
            5'b11101: rv1 <= x29;
            5'b11110: rv1 <= x30;
            5'b11111: rv1 <= x31;
        endcase
        case(rs2)
            5'b00000: rv2 <= x0;
            5'b00001: rv2 <= x1;
            5'b00010: rv2 <= x2;
            5'b00011: rv2 <= x3;
            5'b00100: rv2 <= x4;
            5'b00101: rv2 <= x5;
            5'b00110: rv2 <= x6;
            5'b00111: rv2 <= x7;
            5'b01000: rv2 <= x8;
            5'b01001: rv2 <= x9;
            5'b01010: rv2 <= x10;
            5'b01011: rv2 <= x11;
            5'b01100: rv2 <= x12;
            5'b01101: rv2 <= x13;
            5'b01110: rv2 <= x14;
            5'b01111: rv2 <= x15;
            5'b10000: rv2 <= x16;
            5'b10001: rv2 <= x17;
            5'b10010: rv2 <= x18;
            5'b10011: rv2 <= x19;
            5'b10100: rv2 <= x20;
            5'b10101: rv2 <= x21;
            5'b10110: rv2 <= x22;
            5'b10111: rv2 <= x23;
            5'b11000: rv2 <= x24;
            5'b11001: rv2 <= x25;
            5'b11010: rv2 <= x26;
            5'b11011: rv2 <= x27;
            5'b11100: rv2 <= x28;
            5'b11101: rv2 <= x29;
            5'b11110: rv2 <= x30;
            5'b11111: rv2 <= x31;
        endcase
    end
    

    // on clock edge, if we=1, regfile entry for rd will be updated
    always @(posedge clk) begin 
        if(we) begin
            case(rd)
                5'b00001: x1 <= wdata;
                5'b00010: x2 <= wdata;
                5'b00011: x3 <= wdata;
                5'b00100: x4 <= wdata;
                5'b00101: x5 <= wdata;
                5'b00110: x6 <= wdata;
                5'b00111: x7 <= wdata;
                5'b01000: x8 <= wdata;
                5'b01001: x9 <= wdata;
                5'b01010: x10 <= wdata;
                5'b01011: x11 <= wdata;
                5'b01100: x12 <= wdata;
                5'b01101: x13 <= wdata;
                5'b01110: x14 <= wdata;
                5'b01111: x15 <= wdata;
                5'b10000: x16 <= wdata;
                5'b10001: x17 <= wdata;
                5'b10010: x18 <= wdata;
                5'b10011: x19 <= wdata;
                5'b10100: x20 <= wdata;
                5'b10101: x21 <= wdata;
                5'b10110: x22 <= wdata;
                5'b10111: x23 <= wdata;
                5'b11000: x24 <= wdata;
                5'b11001: x25 <= wdata;
                5'b11010: x26 <= wdata;
                5'b11011: x27 <= wdata;
                5'b11100: x28 <= wdata;
                5'b11101: x29 <= wdata;
                5'b11110: x30 <= wdata;
                5'b11111: x31 <= wdata;
            endcase
        end
    end

endmodule