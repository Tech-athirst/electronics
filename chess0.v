module dff(
    input clk, reset,
    input d,
    output reg q
);
    always @(posedge clk)
        if (reset)
            q <= 0;
        else
            q <= d;
endmodule
module tff (
    input clk, t,
    output reg q
);
    always @(posedge clk)
        if (t)
            q <= ~q;
endmodule
module jkff (
    input clk,
    input j, k,
    output reg q
);
    always @(posedge clk) begin
        case ({j, k})
            2'b00: q <= q;     // No change
            2'b01: q <= 0;     // Reset
            2'b10: q <= 1;     // Set
            2'b11: q <= ~q;    // Toggle
        endcase
    end
endmodule
module srff (
    input clk,
    input s, r,
    output reg q
);
    always @(posedge clk) begin
        if (s & r)
            q <= 1'bx;  // undefined
        else if (s)
            q <= 1;
        else if (r)
            q <= 0;
    end
endmodule

