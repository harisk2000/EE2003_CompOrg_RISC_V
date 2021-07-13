`timescale 1ns/1ps
`define OUTFILE "output.txt"

module outperiph (
    input clk,
    input reset,
    input [31:0] daddr,
    input [31:0] dwdata,
    input [3:0] dwe,
    output [31:0] drdata
);

    reg [31:0] counter;
    integer f; 
    
    initial begin
        counter = 0;
        f = $fopen(`OUTFILE,"w");
    end
    // Implement the peripheral logic here: use $fwrite to the file output.txt
    // Use the `define above to open the file so that it can be 
    // overridden later if needed
    always @(posedge clk) begin
        if(reset)
            counter = 0;
        else if(dwe == 4'b1111) begin // only SW instructions shall call peripheral        
            $fwrite(f,"%c",dwdata);
            counter = counter + 1;
        end
    end
       
    // Return value from here (if requested based on address) should
    // be the number of values written so far
    
    assign drdata = counter;  

endmodule