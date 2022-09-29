SRC_DIR=../../..
ARTYS7_SRC_DIR=$(SRC_DIR)/board/arty_s7
SRCS=$(SRC_DIR)/ktc32.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/maindec.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv

ARTYS7_SRCS=$(ARTYS7_SRC_DIR)/top.sv $(ARTYS7_SRC_DIR)/ram.sv

ARTYS7_INST_PRG=$(ARTYS7_SRC_DIR)/program/inst/program.mem
ARTYS7_LEDLOOP_PRG=$(ARTYS7_SRC_DIR)/program/led_loop/program.mem

.PHONY: all
all: arty_s7_inst_tb.vcd arty_s7_led_loop_tb.vcd

arty_s7_inst_tb.vcd: arty_s7_inst_tb
	vvp arty_s7_inst_tb

arty_s7_inst_tb: arty_s7_inst_tb.sv $(SRCS) $(ARTYS7_SRCS) $(ARTYS7_INST_PRG)
	iverilog -g 2012 -o arty_s7_inst_tb -s arty_s7_inst_tb arty_s7_inst_tb.sv $(ARTYS7_SRCS) $(SRCS)

arty_s7_led_loop_tb.vcd: arty_s7_led_loop_tb
	vvp arty_s7_led_loop_tb

arty_s7_led_loop_tb: arty_s7_led_loop_tb.sv $(SRCS) $(ARTYS7_SRCS) $(ARTYS7_LEDLOOP_PRG) 
	iverilog -g 2012 -o arty_s7_led_loop_tb -s arty_s7_led_loop_tb arty_s7_led_loop_tb.sv $(ARTYS7_SRCS) $(SRCS)

.PHONY: clean
clean:
	rm -rf *.vcd
	rm -rf *_tb