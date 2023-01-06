SRC_DIR:=../src/core
SRCS:=$(SRC_DIR)/ktc32.sv $(SRC_DIR)/controller.sv $(SRC_DIR)/datapath.sv $(SRC_DIR)/flopr.sv $(SRC_DIR)/flopenr.sv \
	 $(SRC_DIR)/mux2.sv $(SRC_DIR)/mux3.sv $(SRC_DIR)/mux4.sv $(SRC_DIR)/regfile.sv $(SRC_DIR)/alu.sv 
ASM_DIR:=asm
ASMS:=$(sort $(wildcard $(ASM_DIR)/*.asm))

TARGET:=$(patsubst %.asm, %.vcd, $(notdir $(ASMS)))

.SILENT:

.PHONY: all
all: $(TARGET)

%.vcd: %_tb
	vvp $<

%_tb: %_tb.sv $(SRCS) %.mem
	iverilog -g 2012 -o $@ -s $@ $< $(SRCS)

%_tb.sv: tb_template.sv
	sed -e 's/inst/$(*F)/g' $< > $@

%.mem: asm/%.asm
	ktc32-asm $< -o $@

.PHONY: clean
clean:
	@echo clean vcd files
	rm -rf *.vcd

