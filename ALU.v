`timescale 1ns/1ps

module alu(instruction,regA,regB,result,flags);

input[31:0] instruction, regA, regB; //the address of regA is 00000, the address of regB is 00001

output reg signed [31:0] result;
output reg[2:0] flags; //the first bit is zero flag, the second bit is negative flag, the third bit is overflow flag.
integer i;
reg [8*5:1] op_str;
reg[31:0] y, zero_y;
reg[31:0] op1, op2;
reg[15:0] imm;
reg[5:0] opcode, func;
reg[4:0] rs, rt, rd, shamt;
always @(instruction,regA,regB)
begin
    flags[2:0] = 3'b000;
    opcode = instruction[31:26];
    func = instruction[5:0];
    rs = instruction[25:21]; //only two different values: 00000, 00001
    rt = instruction[20:16]; //only two different values: 00000, 00001
    rd = instruction[15:11]; //only two different values: 00000, 00001
    imm = instruction[15:0];
    begin
    zero_y = {16'h0000, imm};
    if(imm[15] == 1) begin
        y = {16'hffff, imm};
    end else begin
        y = {16'h0000, imm};
    end  
    end
    //According to opcode, decide which type the instruction is.
    //Then according to funct, decide which operation should be.
    case (opcode)
        6'b001000://addi   rs + sign-extend-imm
            begin
                op_str = "addi";
                if (rs == 5'b00000) begin
                    result = regA + y;
                    if (regA[31] == y[31] && result[31] != regA[31]) begin
                        flags[2] = 1; //overflow
                    end else begin
                        flags[2] = 0; 
                    end
                end else begin
                    result = regB + y;
                    if (regB[31] == y[31] && result[31] != regB[31]) begin
                        flags[2] = 1; //overflow
                    end else begin
                        flags[2] = 0; 
                    end
                end
            end
        6'b001001://addiu
            begin
                op_str = "addiu";
                if (rs == 5'b00000) begin
                    result = regA + y;
                end else begin
                    result = regB + y;
                end
            end
        6'b001100://andi //zero-extended imm
            begin
                op_str = "andi";
                if (rs == 5'b00000) begin
                    result = regA & zero_y;
                end else begin
                    result = regB & zero_y;
                end
            end
        6'b001101://ori zero-extended imm
            begin
                op_str = "ori";
                if (rs == 5'b00000) begin
                    result = regA | zero_y;
                end else begin
                    result = regB | zero_y;
                end
            end
        6'b001110://xori zero-extended imm
            begin
                op_str = "xori";
                if (rs == 5'b00000) begin
                    result = regA ^ zero_y;
                end else begin
                    result = regB ^ zero_y;
                end
            end
        6'b100011://lw
            begin
                op_str = "lw";
                if (rs == 5'b00000) begin
                    result = regA + y;
                end else begin
                    result = regB + y;
                end
            end
        6'b101011://sw
            begin
                op_str = "sw";
                if (rs == 5'b00000) begin
                    result = regA + y;
                end else begin
                    result = regB + y;
                end
            end
        6'b000100://beq
            begin
                op_str = "beq";
                if(rs == 5'b00000 && rt == 5'b00000) begin
                    flags[0] = 1;
                end else if(rs == 5'b00001 && rt == 5'b00001) begin
                    flags[0] = 1;
                end else begin
                    if (regA != regB) begin
                        flags[0] = 0;
                    end else begin
                        flags[0] = 1;
                    end
                end
            end
        6'b000101://bne
            begin
                op_str = "bne";
                if(rs == 5'b00000 && rt == 5'b00000) begin
                    flags[0] = 0;
                end else if(rs == 5'b00001 && rt == 5'b00001) begin
                    flags[0] = 0;
                end else begin
                    if (regA != regB) begin
                        flags[0] = 1;
                    end else begin
                        flags[0] = 0;
                    end
                end
            end
        6'b001010://slti
            begin
                op_str = "slti";
                if (rs == 5'b00000) begin //rs is referencing to regA
                    if(regA[31] != y[31]) begin
                        if(regA[31] > y[31]) begin
                            result = 1;
                            flags[1] = 1; 
                        end else begin
                            result = 0;
                        end
                    end else begin
                        if(regA < y) begin
                            result = 1;
                            flags[1] = 1; 
                        end else begin
                            result = 0;
                        end
                    end
                end else begin
                    if(regB[31] != y[31]) begin
                        if(regB[31] > y[31]) begin
                            result = 1;
                            flags[1] = 1; 
                        end else begin
                            result = 0;
                        end
                    end else begin
                        if(regB < y) begin
                            result = 1;
                            flags[1] = 1; 
                        end else begin
                            result = 0;
                        end
                    end
                end
            end
        6'b000000:
            case (func)
                6'b100000://add
                    begin
                        op_str = "add";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            op1 = regA;
                            op2 = regA;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            op1 = regB;
                            op2 = regB;
                        end else begin
                            op1 = regA;
                            op2 = regB; 
                        end
                        result = op1 + op2;
                        if (op1[31] == op2[31] && result[31] != op1[31]) begin
                            flags[2] = 1; //overflow
                        end else begin
                            flags[2] = 0; 
                        end
                    end
                6'b100001://addu
                    begin
                        op_str = "addu";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            op1 = regA;
                            op2 = regA;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            op1 = regB;
                            op2 = regB;
                        end else begin
                            op1 = regA;
                            op2 = regB; 
                        end
                        result = op1 + op2;
                        if(result[31] == 1) begin
                            flags[1] = 1;
                        end
                    end
                6'b100010://sub
                    begin
                        op_str = "sub";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = 0;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = 0;
                        end else begin
                            if (rs == 5'b00000) begin
                                result = regA + (~regB + 1);
                                if (regA[31] != regB[31] && result[31] == regB[31]) begin
                                    flags[2] = 1;
                                end else begin
                                    flags[2] = 0;
                                end
                            end else begin
                                result = regB + (~regA + 1);
                                if (regA[31] != regB[31] && result[31] == regA[31]) begin
                                    flags[2] = 1;
                                end else begin
                                    flags[2] = 0;
                                end
                            end
                        end
                    end
                6'b100011://subu
                    begin
                        op_str = "subu";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = 0;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = 0;
                        end else begin
                            if (rs == 5'b00000) begin
                                result = regA + (~regB + 1);
                            end else begin
                                result = regB + (~regA + 1);
                            end
                        end
                    end
                6'b100100://and
                    begin
                        op_str = "and";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = regA & regA;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = regB & regB;
                        end else begin
                            result = regA & regB;                                                    
                        end
                    end
                6'b100101://or
                    begin
                        op_str = "or";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = regA | regA;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = regB | regB;
                        end else begin
                            result = regA | regB;                                                    
                        end
                    end
                6'b100110://xor
                    begin
                        op_str = "xor";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = regA ^ regA;
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = regB ^ regB;
                        end else begin
                            result = regA ^ regB;                                                    
                        end
                    end
                6'b100111://nor
                    begin
                        op_str = "nor";
                        if(rs == 5'b00000 && rt == 5'b00000)begin
                            result = ~(regA | regA);
                        end else if(rs == 5'b00001 && rt == 5'b00001) begin
                            result = ~(regB | regB);
                        end else begin
                            result = ~(regA | regB);                                                    
                        end
                    end
                6'b101010://slt
                    begin
                        op_str = "slt";
                        if (rs == 5'b00000) begin
                            if(regA[31] != regB[31]) begin
                                if(regA[31] > regB[31]) begin
                                    result = 1;
                                    flags[1] = 1; 
                                end else begin
                                    result = 0;
                                end
                            end else begin
                                if(regA < regB) begin
                                    result = 1;
                                    flags[1] = 1;
                                end else begin
                                    result = 0;
                                end
                            end
                        end else begin
                            if(regA[31] != regB[31]) begin
                                if(regB[31] > regA[31]) begin
                                    result = 1;
                                    flags[1] = 1;
                                end else begin
                                    result = 0;
                                end
                            end else begin
                                if(regB < regA) begin
                                    result = 1;
                                    flags[1] = 1;
                                end else begin
                                    result = 0;
                                end
                            end
                        end
                    end
                6'b101011://sltu
                    begin
                        op_str = "sltu";
                        if (rs == 5'b00000) begin
                            if(regA < regB) begin
                                result = 1;
                                flags[1] = 1;
                            end else begin
                                result = 0;
                            end
                        end else begin
                            if(regB < regA) begin
                                result = 1;
                                flags[1] = 1;
                            end else begin
                                result = 0;
                            end
                        end
                    end
                6'b000000://sll
                    begin
                        op_str = "sll";
                        shamt = instruction[10:6];
                        if(rt == 5'b00000) begin
                            result = regA << (shamt);
                        end
                        else begin
                            result = regB << (shamt);
                        end //也可以用循环来实现
                    end
                6'b000010://srl
                    begin
                        op_str = "srl";
                        shamt = instruction[10:6];
                        if(rt == 5'b00000) begin
                            result = regA >> (shamt);
                        end
                        else begin
                            result = regB >> (shamt);
                        end //也可以用循环来实现
                    end
                6'b000011://sra
                    begin
                        op_str = "sra";
                        shamt = instruction[10:6];
                        if(rt == 5'b00000) begin
                            y = regA;
                            for(i = shamt; i>0; i = i-1) begin
                                y = {y[31], y[31:1]};
                            end
                            result = y;
                        end
                        else begin
                            y = regB;
                            for(i = shamt; i>0; i = i-1) begin
                                y = {y[31], y[31:1]};
                            end
                            result = y;
                        end
                    end
                6'b000100://sllv
                    begin
                        op_str = "sllv";
                        if(rs == 5'b00000)begin
                            shamt = regA[4:0];
                        end else begin
                            shamt = regB[4:0];
                        end
                        if(rt == 5'b00000) begin
                            result = regA << (shamt);
                        end
                        else begin
                            result = regB << (shamt);
                        end
                    end
                6'b000110://srlv
                    begin
                        op_str = "srlv";
                        if(rs == 5'b00000)begin
                            shamt = regA[4:0];
                        end else begin
                            shamt = regB[4:0];
                        end
                        if(rt == 5'b00000) begin
                            result = regA >> (shamt);
                        end
                        else begin
                            result = regB >> (shamt);
                        end
                    end
                default://srav
                    begin
                        op_str = "srav";
                        if(rt == 5'b00000) begin
                            y = regA;
                            for(i = regB[4:0]; i>0; i = i-1) begin
                                y = {y[31], y[31:1]};
                            end
                            result = y;
                        end
                        else begin
                            y = regB;
                            for(i = regA[4:0]; i>0; i = i-1) begin
                                y = {y[31], y[31:1]};
                            end
                            result = y;
                        end
                    end
            endcase
        6'b001011://sltiu
            begin
                op_str = "sltiu";
                if (rs == 5'b00000) begin
                    if(regA < y) begin
                        result = 1;
                        flags[1] = 1;
                    end else begin
                        result = 0;
                    end
                end else begin
                    if(regB < y) begin
                        result = 1;
                        flags[1] = 1;
                    end else begin
                        result = 0;
                    end
                end
            end
        default:
            result = 0;
    endcase
end

endmodule