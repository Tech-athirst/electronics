module sr_flipflop (
    input clk,
    input s,
    input r,
    output reg q
);
    always @(posedge clk)
        case ({s, r})
            2'b00: q <= q;
            2'b01: q <= 0;
            2'b10: q <= 1;
            2'b11: q <= 1'bx; // Invalid state
        endcase
endmodule
