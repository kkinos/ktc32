module regfile (
    input logic clk,
    input logic we3,
    input logic [4:0] a1,
    input logic [4:0] a2,
    input logic [4:0] a3,
    input logic [15:0] wd3,

    output logic [15:0] rd1,
    output logic [15:0] rd2
);

  logic [15:0] register[0:31];

  always_ff @(posedge clk) begin
    if (we3) register[a3] <= wd3;
  end

  assign rd1 = (a1 != 0) ? register[a1] : 0;  // register 0 is 0
  assign rd2 = (a2 != 0) ? register[a2] : 0;

endmodule
