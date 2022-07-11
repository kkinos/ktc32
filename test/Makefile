SRC_DIR=..
SRCS= $(SRC_DIR)/ktc16.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/maindec.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv ram.sv

.PHONY: all
all: ktc16_1_tb.vcd fibonacci_tb.vcd

ktc16_1_tb.vcd: ktc16_1_tb
	vvp ktc16_1_tb

ktc16_1_tb: ktc16_1_tb.sv $(SRCS) ktc16_1.mem
	iverilog -g 2012 -o ktc16_1_tb -s ktc16_1_tb ktc16_1_tb.sv $(SRCS)

fibonacci_tb.vcd: fibonacci_tb
	vvp fibonacci_tb

fibonacci_tb: fibonacci_tb.sv $(SRCS) fibonacci.mem
	iverilog -g 2012 -o fibonacci_tb -s fibonacci_tb fibonacci_tb.sv $(SRCS)

.PHONY: clean
clean:
	rm -rf *.vcd
	rm -rf ktc16_1_tb
	rm -rf fibonacci_tb