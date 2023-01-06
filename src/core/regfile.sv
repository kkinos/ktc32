module regfile (
    input logic clk,
    input logic [2:0] we3,
    input logic [4:0] a1,
    input logic [4:0] a2,
    input logic [4:0] a3,
    input logic [31:0] wd3,

    output logic [31:0] rd1,
    output logic [31:0] rd2
);

  logic [31:0] register[0:31];


  always_ff @(posedge clk) begin
    case (we3)
      3'b001:  register[a3] <= {24'b0, wd3[7:0]};
      3'b010:  register[a3] <= {{24{wd3[7]}}, wd3[7:0]};
      3'b011:  register[a3] <= {16'b0, wd3[15:0]};
      3'b100:  register[a3] <= {{16{wd3[15]}}, wd3[15:0]};
      3'b101:  register[a3] <= wd3;
      default: ;
    endcase
  end

  assign rd1 = (a1 != 0) ? register[a1] : 0;  // register 0 is 0
  assign rd2 = (a2 != 0) ? register[a2] : 0;

endmodule
