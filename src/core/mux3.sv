module mux3 #(
    parameter WIDTH = 8
) (
    input logic [WIDTH-1:0] d0,
    input logic [WIDTH-1:0] d1,
    input logic [WIDTH-1:0] d2,
    input logic [1:0] s,

    output logic [WIDTH-1:0] y
);

  always_comb begin
    casex (s)
      2'b00: y = d0;
      2'b01: y = d1;
      2'b1x: y = d2;
    endcase
  end


endmodule
