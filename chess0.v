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
module ram(
    input clk,rw,en,
    input[4,0] data_in,
    input[5,0] adress,
    output reg[4,0] data_out
    );
    reg[4,0] memory[63:0]; // 64x5 RAM
    initial begin
        for(int i=1; i <= 64; i = i + 1) 
             {
                if(i==8)
                    memory[i] = 5'b00001; //a2
                if(i==9)
                memory[i] = 5'b00010; //b2          
                if(i==2)
                    memory[i] = 5'b00001; //c2
                 if(i==10)
                    memory[i] = 5'b00011; //d2
                if(i==11)
                    memory[i] = 5'b00100;//e2
                if(i==12)
                    memory[i] = 5'b00101;//f2
                if(i==13)
                    memory[i] = 5'b00110;//g2
                if(i==14)
                    memory[i] = 5'b00111;//h2
                if(i==15)
                    memory[i] = 5'b01000;
                if(i==49)  
                    memory[i] = 5'b01001;
                if(i==50)
                    memory[i] = 5'b01010;
                if(i==51)
                    memory[i] = 5'b01011;        
                if(i==52)   
                    memory[i] = 5'b01100;
                if(i==53)
                    memory[i] = 5'b01101;
                if(i==54)
                    memory[i] = 5'b01110;
                if(i==55)
                    memory[i] = 5'b01111;
                if(i==56)
                    memory[i] = 5'b10000;
                if(i==1)
                    memory[i] = 5'b10111;//a1 rook
                if(i==8)
                    memory[i] = 5'b11000;//a8 rook
                if(i==2)
                    memory[i] = 5'b10110;//b1 knight
                if(i==7)
                    memory[i] = 5'b01111;//b8 knight
                if(i==3)
                    memory[i] = 5'b10000;//c1 bishop
                if(i==6)
                    memory[i] = 5'b11010;//c8 bishop   
                if(i==4)
                    memory[i] = 5'b10100;//d1 queen
                if(i==5)
                    memory[i] = 5'b10011;//e1 king
           
                

                
             }
        
    end 
    always @(posedge clk) begin
        if (en) begin
            if (rw) begin // Write operation
                memory[adress] <= data_in;
            end else begin // Read operation
                data_out <= memory[adress];
            end
        end
    end
endmodule
