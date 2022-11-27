`timescale 1ns / 1ns

module inst_tb;

  logic clk, reset;
  logic [31:0] rd;

  logic [31:0] addr;
  logic [31:0] wd;
  logic [ 1:0] memwrite;

  parameter STEP = 10;

  always begin
    clk = 0;
    #STEP;
    clk = 1;
    #STEP;
  end

  initial begin
    reset = 0;
    #STEP reset = 1;
    #STEP reset = 0;
  end

  logic [7:0] mem[0:1024];
  initial $readmemh("inst.mem", mem);

  always_ff @(posedge clk) begin
    case (memwrite)
      2'b01:   mem[addr] <= wd[7:0];
      2'b10: begin
        mem[addr]   <= wd[7:0];
        mem[addr+1] <= wd[15:8];
      end
      2'b11: begin
        mem[addr]   <= wd[7:0];
        mem[addr+1] <= wd[15:8];
        mem[addr+2] <= wd[23:16];
        mem[addr+3] <= wd[31:24];
      end
      default: ;
    endcase
  end

  assign rd = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};

  ktc32 ktc32 (
      clk,
      reset,
      rd,
      memwrite,
      addr,
      wd
  );

  always @(negedge clk) begin
    if (memwrite) begin
      if (wd == 4 && addr == 80) begin
        $display("\x1b[32m");
        $display("=== inst test succeeded ===");
        $display("\x1b[0m");
        $finish;
      end else if (wd == 3 && addr == 80) begin
        $display("\x1b[31m");
        $display("=== inst test failed ===");
        $display("\x1b[0m");
        $finish;
      end
    end
  end

  initial begin
    $dumpfile("inst_tb.vcd");
    $dumpvars(0, inst_tb);
  end

endmodule
