`timescale 1ns/1ps

module alu_test;

reg[31:0] instruction, regA, regB;
wire[31:0] result;
wire[2:0] flags;

alu testalu(instruction,regA,regB,result,flags);

initial
begin

// $display("instruction:op:reg_A   :reg_B   :result  :flags:funct :y       :imm");
$monitor("operation:%s; instruction: 0x%h; reg_A: 0x%h; reg_B: 0x%h; result: 0x%h; flags: 0b%3b",
testalu.op_str,testalu.instruction, testalu.regA, testalu.regB, testalu.result, testalu.flags);

//sll已通过测试
#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0100_0000;
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移1位

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1000_0000;
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101;//dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移2位

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0100_0000;
    regA<=32'b0100_0000_0100_0000_0100_0000_0100_0000; //40404040
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移1位

#10 instruction<=32'b0000_0000_0000_0001_0001_0001_0000_0000;
    regA<=32'b0100_0000_0100_0000_0100_0000_0100_0000; //40404040
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移4位


//add已通过测试！
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0000;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0101; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 00000006:000

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0000;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 80000000:100

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0000;
    regA<=32'b1111_1111_1111_1111_1111_1111_1111_1110; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 80000000:100

//addu
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0101; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 00000006:000

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0001;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 80000000:100

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0001;
    regA<=32'b1111_1111_1111_1111_1111_1111_1111_1110; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 80000000:100

// //sub已通过测试！
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0010; //regA - regB
    regA<=32'b1000_0000_0000_0000_0000_0000_0000_0000; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 7fffffff:100

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0010; //regA - regB
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 7ffffffe

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0010; //regA - regB
    regB<=32'b1000_0000_0000_0000_0000_0000_0000_0000; //
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //res = 80000001:100

//subu
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0011; //regA - regB
    regA<=32'b1000_0000_0000_0000_0000_0000_0000_0000; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0011; //regA - regB
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111; //
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0011; //regA - regB
    regB<=32'b1000_0000_0000_0000_0000_0000_0000_0000; //
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 



//srlv已通过测试！
#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0000_0110;
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //右移1位

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0000_0110;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //右移1位

//sllv已通过测试！
#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0000_0100;
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移1位

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0000_0100;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; //左移1位

//sra已通过测试！
#10 instruction<=32'b0000_0000_0000_0000_0000_0000_0100_0011;//算术右移1位
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0000_0000_0000_0000_0100_0011;//算术右移1位
    regA<=32'b1000_1101_1101_1101_1101_1101_1101_0001; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0000_0000_0000_0000_0100_0011; //算术右移1位
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

// //srav已通过测试！
#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0000_0111;//算术右移1位
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0100_0011;//算术右移1位
    regA<=32'b1000_1101_1101_1101_1101_1101_1101_0001; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0100_0011; //算术右移1位
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

//srl已通过测试
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0100_0010;
    regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101; //dddd_dddd
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; //右移1位

//addi指令已通过测试
#10 instruction<=32'b0010_0000_0010_0000_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001; //res = 0000001a

#10 instruction<=32'b0010_0000_0000_0000_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;  //res = 0000000c

#10 instruction<=32'b0010_0000_0000_0000_0000_0000_0000_1001;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;  //res = 80000008:100

//addiu
#10 instruction<=32'b0010_0100_0010_0000_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001; //res = 0000001a

#10 instruction<=32'b0010_0100_0000_0001_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;  //res = 0000000c

#10 instruction<=32'b0010_0100_0000_0000_1000_0000_0000_1001;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;

//lw
#10 instruction<=32'b1000_1100_0010_0000_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001; 

#10 instruction<=32'b1000_1100_0000_0001_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;  

#10 instruction<=32'b1000_1100_0000_0000_1000_0000_0000_1001;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;

//sw
#10 instruction<=32'b1010_1100_0010_0000_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001; //res = 0000001a

#10 instruction<=32'b1010_1100_0000_0001_0000_0000_0000_1001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;  //res = 0000000c

#10 instruction<=32'b1010_1100_0000_0000_1000_0000_0000_1001;
    regA<=32'b0111_1111_1111_1111_1111_1111_1111_1111;
    regB<=32'b0000_0000_0000_0000_0000_0000_0001_0001;

//and指令已通过测试
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0100;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011; 

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0100;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010;

//or指令
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0101;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011; //res = 0000002f

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0101;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; //res = 00000007

//ori
#10 instruction<=32'b0011_0100_0000_0001_0000_0000_0010_0101;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011; 

#10 instruction<=32'b0011_0100_0000_0001_1000_0000_0010_0101;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 


// //xor指令
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0110;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011;  //res = 00000006

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0110;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; //res=00000005

//xori
#10 instruction<=32'b0011_1000_0000_0001_0000_0000_0010_0110;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011;  

#10 instruction<=32'b0011_1000_0000_0001_1000_0000_0010_0110;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 


// //nor指令
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0010_1101; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0010_1011; //res = ffffffd0

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; //res = fffffff8

// //beq
#10 instruction<=32'b0001_0000_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 

#10 instruction<=32'b0001_0000_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 

// //bne
#10 instruction<=32'b0001_0100_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 

#10 instruction<=32'b0001_0100_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 

// //andi
#10 instruction<=32'b0011_0000_0000_0001_0000_0000_0010_0111;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 

#10 instruction<=32'b0011_0000_0000_0001_0000_0000_0010_0001;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 

//slt
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_1010;
    regA<=32'b1011_1111_1111_1111_1111_1111_1111_1111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 

//sltu
#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_1011;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 

#10 instruction<=32'b0000_0000_0000_0001_0000_0000_0010_1011;
    regA<=32'b1011_1111_1111_1111_1111_1111_1111_1111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0001; 

#10 instruction<=32'b0000_0000_0010_0000_0000_0000_0010_1011;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 

//slti
#10 instruction<=32'b0010_1000_0000_0000_0000_0000_0000_1010;
    regA<=32'b0000_0000_0000_0000_0000_1000_0000_0001; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010;  //res = 0

#10 instruction<=32'b0010_1000_0000_0001_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111;  //res = 1 flags[1] = 1

#10 instruction<=32'b0010_1000_0010_0000_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; //res = 1 flags[1] = 1

//sltiu
#10 instruction<=32'b0010_1100_0000_0000_0000_0000_0000_1010;
    regA<=32'b0000_0000_0000_0000_0000_1000_0000_0001; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010;  

#10 instruction<=32'b0010_1100_0000_0001_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0111;  

#10 instruction<=32'b0010_1100_0010_0000_0000_0000_0010_1010;
    regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111; 
    regB<=32'b0000_0000_0000_0000_0000_0000_0000_0010; 



#10 $finish;
end

endmodule