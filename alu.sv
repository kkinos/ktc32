module alu (
    input logic [15:0] srca,
    input logic [15:0] srcb,
    input logic [ 2:0] alucontrol,

    output logic [15:0] res,
    output logic zero
);

  always_comb begin
    case (alucontrol)
      3'b000: res = srca & srcb;
      3'b001: res = srca | srcb;
      3'b010: res = srca + srcb;
      3'b110: res = srcb - srca;
      3'b111: res = (srcb < srca) ? 1 : 0;
    endcase
    zero = ~(|res);
  end


endmodule
