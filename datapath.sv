module datapath (
    input logic clk,
    input logic reset,

    input logic [31:0] rd,
    input logic pcen,

    input logic iord,
    input logic irwrite,
    input logic memtoreg,
    input logic regwrite,
    input logic alusrca,
    input logic [1:0] alusrcb,
    input logic [2:0] alucontrol,
    input logic pcsrc,

    output logic [31:0] instr,
    output logic zero,
    output logic [15:0] addr,
    output logic [15:0] wd
);

  logic [15:0] pc;
  logic [15:0] pcnext;
  logic [15:0] data;
  logic [15:0] wd3;
  logic [15:0] rd1;
  logic [15:0] rd2;
  logic [15:0] a;
  logic [15:0] b;
  logic [15:0] pcplus;
  logic [15:0] srca;
  logic [15:0] srcb;
  logic [15:0] alures;
  logic [15:0] aluout;

  flopenr #(
      .WIDTH(16)
  ) pcreg (
      clk,
      reset,
      pcen,
      pcnext,
      pc
  );

  mux2 #(
      .WIDTH(16)
  ) admux (
      pc,
      aluout,
      iord,
      addr
  );

  flopenr #(
      .WIDTH(32)
  ) instreg (
      clk,
      reset,
      irwrite,
      rd,
      instr
  );

  flopr #(
      .WIDTH(16)
  ) datareg (
      clk,
      reset,
      rd[15:0],
      data
  );

  mux2 #(
      .WIDTH(16)
  ) wdmux (
      aluout,
      data,
      memtoreg,
      wd3
  );

  regfile regfile (
      clk,
      regwrite,
      instr[15:11],
      instr[10:6],
      instr[10:6],
      wd3,
      rd1,
      rd2
  );

  flopr #(
      .WIDTH(16)
  ) rd1reg (
      clk,
      reset,
      rd1,
      a
  );

  flopr #(
      .WIDTH(16)
  ) rd2reg (
      clk,
      reset,
      rd2,
      b
  );

  assign wd = b;


  mux2 #(
      .WIDTH(16)
  ) srcamux (
      pc,
      a,
      alusrca,
      srca
  );

  mux2 #(
      .WIDTH(16)
  ) pcplusmux (
      16'd2,
      16'd4,
      rd[0],
      pcplus
  );


  mux4 #(
      .WIDTH(16)
  ) srcbmux (
      b,
      pcplus,
      16'b0,
      instr[31:16],
      alusrcb,
      srcb
  );

  alu alu (
      srca,
      srcb,
      alucontrol,
      alures,
      zero
  );

  flopr #(
      .WIDTH(16)
  ) resreg (
      clk,
      reset,
      alures,
      aluout
  );

  mux2 #(
      .WIDTH(16)
  ) resmux (
      alures,
      instr[31:16],
      pcsrc,
      pcnext
  );


endmodule
