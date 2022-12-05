SRC_DIR:=../../../src
SRCS:=$(SRC_DIR)/ktc32.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux3.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv

ARTYS7_SRC_DIR:=../src
ARTYS7_SRCS:=$(ARTYS7_SRC_DIR)/top.sv $(ARTYS7_SRC_DIR)/ram.sv $(ARTYS7_SRC_DIR)/uart_tx.sv 

LEDLOOP_PRG:=../program/led_loop.mem
SERIALSEND_PRG:=../program/serial_send.mem

.SILENT:

.PHONY: all
all: led_loop_tb.vcd serial_send_tb.vcd

led_loop_tb.vcd: led_loop_tb
	vvp led_loop_tb

led_loop_tb: led_loop_tb.sv $(SRCS) $(ARTYS7_SRCS) $(LEDLOOP_PRG)
	iverilog -g 2012 -o led_loop_tb -s led_loop_tb led_loop_tb.sv $(ARTYS7_SRCS) $(SRCS)

serial_send_tb.vcd: serial_send_tb
	vvp serial_send_tb

serial_send_tb: serial_send_tb.sv $(SRCS) $(ARTYS7_SRCS) $(SERIALSEND_PRG)
	iverilog -g 2012 -o serial_send_tb -s serial_send_tb serial_send_tb.sv $(ARTYS7_SRCS) $(SRCS)

.PHONY: clean
clean:
	@echo clean files
	rm -rf *.vcd
	rm -rf *_tb