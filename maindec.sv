module maindec (
    input logic clk,
    input logic reset,
    input logic [5:0] op,

    output logic memtoreg,
    output logic iord,
    output logic pcsrc,
    output logic alusrca,
    output logic [1:0] alusrcb,
    output logic [2:0] alucontrol,

    output logic irwrite,
    output logic memwrite,
    output logic pcwrite,
    output logic branch,
    output logic regwrite
);

  parameter MOV = 6'b000000, ADD = 6'b100000, SUB = 6'b110000, AND = 6'b010000, OR = 6'b011000, SLT = 6'b001000;
  parameter LW = 6'b000011, ADDI = 6'b100011;
  parameter SW = 6'b000111;
  parameter JMP = 6'b000001, JEQ = 6'b100001;

  typedef enum logic [3:0] {
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
    S6,
    S7,
    S8,
    S9,
    S10,
    S11,
    S12,
    S13,
    S14,
    S15
  } statetype;
  statetype state, nextstate;

  always_ff @(posedge clk, posedge reset)
    if (reset) state <= S0;
    else state <= nextstate;

  always_comb
    case (state)
      S0: begin
        nextstate = S1;

        memtoreg = 'x;
        iord = 1'b0;
        pcsrc = 1'b0;
        alusrca = 1'b0;
        alusrcb = 2'b01;
        alucontrol = 3'b010;

        irwrite = 1'b1;
        memwrite = 1'b0;
        pcwrite = 1'b1;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S1: begin
        case (op)
          LW:   nextstate = S2;
          SW:   nextstate = S2;
          ADDI: nextstate = S9;
          MOV:  nextstate = S6;
          ADD:  nextstate = S6;
          SUB:  nextstate = S6;
          AND:  nextstate = S6;
          OR:   nextstate = S6;
          SLT: nextstate = S6;
          JEQ: nextstate = S8;
          JMP: nextstate = S10;
        endcase
        memtoreg = 'x;
        iord = 'x;
        pcsrc = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S2: begin
        case (op)
          LW: nextstate = S3;
          SW: nextstate = S5;
        endcase

        memtoreg = 'x;
        iord = 'x;
        pcsrc = 'x;
        alusrca = 1'b1;
        alusrcb = 2'b11;
        alucontrol = 3'b010;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S3: begin
        nextstate = S4;

        memtoreg = 'x;
        iord = 1'b1;
        pcsrc = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S4: begin
        nextstate = S0;

        memtoreg = 1'b1;
        iord = 'x;
        pcsrc = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b1;
      end

      S5: begin
        nextstate = S0;

        memtoreg = 'x;
        iord = 1'b1;
        pcsrc = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b1;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S6: begin
        nextstate = S7;

        if (op == MOV) begin
          memtoreg = 'x;
          iord = 'x;
          pcsrc = 'x;
          alusrca = 1'b1;
          alusrcb = 2'b10;
          alucontrol = 3'b010;

          irwrite = 1'b0;
          memwrite = 1'b0;
          pcwrite = 1'b0;
          branch = 1'b0;
          regwrite = 1'b0;
        end else begin
          memtoreg = 'x;
          iord = 'x;
          pcsrc = 'x;
          alusrca = 1'b1;
          alusrcb = 2'b00;

          case (op)
            ADD: alucontrol = 3'b010;
            SUB: alucontrol = 3'b110;
            AND: alucontrol = 3'b000;
            OR: alucontrol = 3'b001;
            SLT: alucontrol = 3'b111;
          endcase

          irwrite  = 1'b0;
          memwrite = 1'b0;
          pcwrite  = 1'b0;
          branch   = 1'b0;
          regwrite = 1'b0;
        end
      end

      S7: begin
        nextstate = S0;

        memtoreg = 1'b0;
        iord = 'x;
        pcsrc = 'x;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b1;
      end

      S8: begin
        nextstate = S0;

        memtoreg = 'x;
        iord = 'x;
        pcsrc = 1'b1;
        alusrca = 1'b1;
        alusrcb = 2'b00;
        alucontrol = 3'b110;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b1;
        regwrite = 1'b0;

      end

      S9: begin
        nextstate = S7;

        memtoreg = 'x;
        iord = 'x;
        pcsrc = 1'b0;
        alusrca = 1'b1;
        alusrcb = 2'b11;
        alucontrol = 3'b010;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b0;
        branch = 1'b0;
        regwrite = 1'b0;
      end

      S10: begin
        nextstate = S0;

        memtoreg = 'x;
        iord = 'x;
        pcsrc = 1'b1;
        alusrca = 'x;
        alusrcb = 'x;
        alucontrol = 'x;

        irwrite = 1'b0;
        memwrite = 1'b0;
        pcwrite = 1'b1;
        branch = 1'b0;
        regwrite = 1'b0;
      end

    endcase
endmodule
