module ram (
    input logic clk,
    input logic we,
    input logic [15:0] addr,
    input logic [15:0] wd,
    output logic [31:0] data
);

  logic [7:0] mem[0:32767];
  initial $readmemh("program.mem", mem);

  always_ff @(posedge clk) begin
    if (we) begin
      mem[addr]   <= wd[7:0];
      mem[addr+1] <= wd[15:8];
    end

  end

  assign data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};

endmodule
