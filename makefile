.PHONY: com run 

OUTPUT = ALU

com:
	iverilog -W all -o ${OUTPUT} ALU.v test_ALU.v
run:
	./${OUTPUT}
