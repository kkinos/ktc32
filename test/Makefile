SRC_DIR=..
SRCS= $(SRC_DIR)/ktc32.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/maindec.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv $(SRC_DIR)/ram.sv

INST1PRG=../program/inst1/program.mem
FIBOPRG=../program/fibonacci/program.mem

.PHONY: all
all: inst1_tb.vcd fibonacci_tb.vcd

inst1_tb.vcd: inst1_tb
	vvp inst1_tb

inst1_tb: inst1_tb.sv $(SRCS) $(INST1PRG)
	iverilog -g 2012 -o inst1_tb -s inst1_tb inst1_tb.sv $(SRCS)

fibonacci_tb.vcd: fibonacci_tb
	vvp fibonacci_tb

fibonacci_tb: fibonacci_tb.sv $(SRCS) $(FIBOPRG)
	iverilog -g 2012 -o fibonacci_tb -s fibonacci_tb fibonacci_tb.sv $(SRCS)

.PHONY: clean
clean:
	rm -rf *.vcd
	rm -rf *_tb