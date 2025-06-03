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
module and(
    input a,b,
    output aandb
);
    always@(a,b) begin
        if(a&&b)
            aandb=1;
            else
            aandb=0;
    end
endmodule
module or(
    input a,b,
    output aorb
);
    always@(a,b) begin
        if(a||b)
            aorb=1;
            else
            aorb=0;
    end
endmodule
module not(
    input a,
    output nota
);
    always@(a) begin
        if(a)
            nota=0;
            else
            nota=1;
    end
endmodule
module nand(
    input a,b,
    output nandab
);
    always@(a,b) begin
        if(!(a&&b))
            nandab=1;
            else
            nandab=0;
    end
endmodule
module nor(
    input a,b,
    output norab
);
    always@(a,b) begin
        if(!(a||b))
            norab=1;
            else
            norab=0;
    end
endmodule
module xor(
    input a,b,
    output xorab
);
    always@(a,b) begin
        if(a^b)
            xorab=1;
            else
            xorab=0;
    end
endmodule
module xnor(
    input a,b,
    output xnorab
);
    always@(a,b) begin
        if(!(a^b))
            xnorab=1;
            else
            xnorab=0;
    end
endmodule
module mux2to1(
    input a,b,sel,
    output out
);
    always@(a,b,sel) begin
        if(sel)
            out=b;
            else
            out=a;
    end
endmodule
module mux4to1(
    input a,b,c,d,sel0,sel1,
    output out
);
    wire sel0n, sel1n;
    not(sel0n, sel0);
    not(sel1n, sel1);
    
    wire ab, cd;
    mux2to1 m1(a, b, sel0, ab);
    mux2to1 m2(c, d, sel0, cd);
    mux2to1 m3(ab, cd, sel1, out);
endmodule
module mux8to1(
    input a,b,c,d,e,f,g,h,sel0,sel1,sel2,
    output out
);
    wire sel0n, sel1n, sel2n;
    not(sel0n, sel0);
    not(sel1n, sel1);
    not(sel2n, sel2);
    
    wire abcd, efgh;
    mux4to1 m1(a, b, c, d, sel0, sel1, abcd);
    mux4to1 m2(e, f, g, h, sel0, sel1, efgh);
    mux2to1 m3(abcd, efgh, sel2, out);
endmodule
