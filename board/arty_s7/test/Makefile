SRC_DIR=../../..
SRCS=$(SRC_DIR)/ktc32.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/maindec.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv $(SRC_DIR)/ram.sv

ARTYS7TOP=$(SRC_DIR)/board/arty_s7/top.sv

ARTYS7INSTPRG=$(SRC_DIR)/board/arty_s7/program/inst/program.mem
ARTYS7LEDLOOPPRG=$(SRC_DIR)/board/arty_s7/program/led_loop/program.mem

.PHONY: all
all: arty_s7_inst_tb.vcd arty_s7_led_loop_tb.vcd

arty_s7_inst_tb.vcd: arty_s7_inst_tb
	vvp arty_s7_inst_tb

arty_s7_inst_tb: arty_s7_inst_tb.sv $(SRC) $(ARTYS7INSTPRG) $(ARTYS7TOP)
	iverilog -g 2012 -o arty_s7_inst_tb -s arty_s7_inst_tb arty_s7_inst_tb.sv $(ARTYS7TOP) $(SRCS)

arty_s7_led_loop_tb.vcd: arty_s7_led_loop_tb
	vvp arty_s7_led_loop_tb

arty_s7_led_loop_tb: arty_s7_led_loop_tb.sv $(SRC) $(ARTYS7LEDLOOPPRG) $(ARTYS7TOP)
	iverilog -g 2012 -o arty_s7_led_loop_tb -s arty_s7_led_loop_tb arty_s7_led_loop_tb.sv $(ARTYS7TOP) $(SRCS)

.PHONY: clean
clean:
	rm -rf *.vcd
	rm -rf *_tb