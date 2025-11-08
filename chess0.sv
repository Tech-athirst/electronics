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
// module ram(
//     input clk,rw,en,
//     input[4,0] data_in,
//     input[5,0] adress,
//     output reg[4,0] data_out
//     );
//     reg[4,0] memory[63:0]; // 64x5 RAM
//     always @(posedge clk) 
//     begin
//         if (en) begin
//             if (rw) 
//             begin // Write operation
//                 memory[adress] <= data_in;
//             end 
//             else 
//             begin // Read operation
//                 data_out <= memory[adress];
//             end
//         end
//     end
// endmodule
module ram(
    input clk,rw,en,
    input[4,0] data_in,
    input[5,0] adress,
   // output reg[4,0] data_out
    );
    
    reg[4,0] memory[63:0]; // 64x5 RAM
    initial begin
       
        for(int i=1; i <= 64; i = i + 1) 
             {
              
                if(i==9)
                    memory[i] = 1; //a2          
                if(i==10)
                    memory[i] = 2; //b2
                 if(i==11)
                    memory[i] = 3; //c2
                if(i==12)
                    memory[i] = 4;//d2
                if(i==13)
                    memory[i] = 5;//e2
                if(i==14)
                    memory[i] = 6;//f2
                if(i==15)
                    memory[i] = 7;//g2
                if(i==16)
                    memory[i] = 8;// h2
                if(i==49)  
                    memory[i] = 17;//a7
                if(i==50)
                    memory[i] = 19;// b7
                if(i==51)
                    memory[i] = 19;//c7     
                if(i==52)   
                    memory[i] = 20;//d7
                if(i==53)
                    memory[i] = 21;//e7
                if(i==54)
                    memory[i] = 22;//f7
                if(i==55)
                    memory[i] = 23;//g7
                if(i==56)
                    memory[i] = 24;//h7
                if(i==1)
                    memory[i] = 13;//a1 rook
                if(i==8)
                    memory[i] = 14;//h1 rook
                if(i==2)
                    memory[i] = 9;//b1 knight
                if(i==7)
                    memory[i] = 10;//g8 knight
                if(i==3)
                    memory[i] = 11;//c1 bishop
                if(i==6)
                    memory[i] = 12;//f1 bishop   
                if(i==4)
                    memory[i] = 15;//d1 queen
                if(i==5)
                    memory[i] = 16;//e1  king


                if(i==57)
                    memory[i] = 29;//a8 rook
                if(i==64)
                    memory[i] = 30;//h8 rook
                if(i==58)
                    memory[i] = 25;//b8 knight
                if(i==63)
                    memory[i] = 26;//g8 knight
                if(i==59)
                    memory[i] = 27;//c8 bishop
                if(i==62)
                    memory[i] = 28;//f8 bishop   
                if(i==60)
                    memory[i] = 31;//d8 queen
                if(i==61)
                    memory[i] = 32;//e8 king
            else
                memory[i] = 0;
              } // Initialize other cells to 0
    end 
    always @(posedge clk) 
    begin
        if (en) begin
            if (rw) 
            begin // Write operation
                memory[adress] <= data_in;
            end 
            else 
            begin // Read operation
                data_out <= memory[adress];
            end
        end
    end
endmodule
module main_ram(
    input clk,rw,
    input[4:0] data_in,
    input[5:0] adress,
    output reg[4:0] data_out 

);
    wire [4:0] data_out_wire;
    ram r1(
        .clk(clk),
        .rw(rw),
        .data_in(data_in),
        .adress(adress),
        .data_out(data_out_wire)
    );
    
    always @(posedge clk) begin
        data_out <= data_out_wire;
    end
endmodule


module legal_rook(
    input clk,
    input [4:0] data_in,
    output reg [4:0] data_out,

);
wire [4:0]  data_out;
reg [4:0] data_out_rook;

always @(*) begin 
    {
        
        for(int j=1;j<=64;j++)
        {
            if(data_out[i]>=17)
            
           
        }
    }
    
end
endmodule
