module programmer #(
    parameter int unsigned UART_BAUD_RATE = 9600,
    parameter int unsigned CPU_FREQ_HZ = 75_000_000
)(
  input logic       clk,
  input logic       rst_n,
  
  output logic         mem_req,
  input  logic         mem_gnt,
  output logic         mem_we,
  output logic [31:0]  mem_addr,
  output logic [127:0] mem_wdata,
  output logic [15:0]  mem_wstrb,
  
  input logic       ram_prog_rx_i,
  output logic      system_reset_no,
  output logic      programming_active,
  output logic      programming_state_on
);
  localparam DEFAULT_DIV = CPU_FREQ_HZ / UART_BAUD_RATE;

    logic [3:0]   recv_state;
	logic [31:0]  recv_divcnt;
	logic [7:0]   recv_pattern;
	logic [7:0]   recv_buf_data;
	logic         recv_buf_valid;

  logic ram_prog_rd_en;

  // UART part
  always_ff@(posedge clk) begin
    if(~rst_n) begin
      recv_state     <= '0;
      recv_divcnt    <= '0;
      recv_pattern   <= '0;
      recv_buf_data  <= '0;
      recv_buf_valid <= '0;
    end else begin
      recv_divcnt <= recv_divcnt + 32'd1;
      if(ram_prog_rd_en)
        recv_buf_valid <= 1'b0;
      case(recv_state)
        0: begin
          if(~ram_prog_rx_i)
            recv_state <= 1;
          recv_divcnt <= 0;
        end
        1: begin
          if(2*recv_divcnt > DEFAULT_DIV) begin
            recv_state <= 2;
            recv_divcnt <= 0;
          end
        end
        10: begin
          if(recv_divcnt > DEFAULT_DIV) begin
            recv_buf_data  <= recv_pattern;
            recv_buf_valid <= 1;
            //$display("[%0t] Received byte: 0x%x", $realtime, recv_pattern);
            recv_state     <= 0;
          end
        end
        default: begin
          if(recv_divcnt > DEFAULT_DIV) begin
            recv_pattern <= {ram_prog_rx_i, recv_pattern[7:1]};
            recv_state <= recv_state + 1;
            recv_divcnt <= '0;
          end
        end
      endcase
    end
  end

  localparam PROGRAM_SEQUENCE    = "TEKNOFEST";
  localparam PROG_SEQ_LENGTH     = 9;
  localparam SEQ_BREAK_THRESHOLD = 32'd1000000;

  logic [PROG_SEQ_LENGTH*8-1:0] received_sequence;
  logic [3:0]                   rcv_seq_ctr;

  logic  [31:0] sequence_break_ctr;
  wire          sequence_break = sequence_break_ctr == SEQ_BREAK_THRESHOLD;

  typedef enum logic [2:0] {
    SequenceWait,
    SequenceReceive,
    SequenceCheck,
    SequenceLengthCalc,
    SequenceProgram,
    SequenceFinish
  } state_prog_t;

  state_prog_t state_prog, state_prog_next;

  logic [3:0]  instruction_byte_ctr;
  logic [127:0] prog_instruction;
  logic [127:0] prog_instruction_ordered;
  logic [31:0] prog_intr_number;
  logic [31:0] prog_intr_ctr;

  assign programming_active = state_prog == SequenceProgram && instruction_byte_ctr == '0;
  assign programming_state_on = state_prog == SequenceProgram;

  logic prog_inst_valid;
  logic prog_sys_rst_n;

  always_comb begin
    state_prog_next = state_prog;
    case(state_prog)
      SequenceWait: begin
        if(recv_buf_valid) begin
          state_prog_next = SequenceReceive;
        end
      end

      SequenceReceive: begin
        if(recv_buf_valid) begin
          if(rcv_seq_ctr == PROG_SEQ_LENGTH-1) begin
            state_prog_next = SequenceCheck;
          end
        end else if(sequence_break) begin
          state_prog_next = SequenceWait;
        end
      end

      SequenceCheck: begin
        if(received_sequence == PROGRAM_SEQUENCE) begin
          state_prog_next = SequenceLengthCalc;
        end else begin
          state_prog_next = SequenceWait;
        end
      end

      SequenceLengthCalc: begin
        if(recv_buf_valid && instruction_byte_ctr[1:0] == 2'b11) begin
          state_prog_next = SequenceProgram;
        end
      end

      SequenceProgram: begin
        if(prog_intr_ctr >= prog_intr_number) begin
          state_prog_next = SequenceFinish;
        end
      end

      SequenceFinish: begin
        state_prog_next = SequenceWait;
      end
    endcase
  end

  assign ram_prog_rd_en = (state_prog != SequenceFinish);

  logic [31:0] prog_addr;
  always @(posedge clk) begin
    if (!rst_n) begin // eski hali: (!(rst_n && system_reset_no))
      prog_addr <= 'h0;
    end else begin
      if ((state_prog == SequenceProgram) && prog_inst_valid) begin
        prog_addr <= prog_addr + 'd16;
      end
    end
  end

  always @(posedge clk) begin
    if (!rst_n) begin
      state_prog <= SequenceWait;
    end else begin
      state_prog <= state_prog_next;
    end
  end

  always_ff@(posedge clk) begin
    if(~rst_n) begin
      instruction_byte_ctr <= 4'b0;
      prog_instruction     <= 128'h0;
      prog_intr_number     <= 32'h0;
      prog_intr_ctr        <= 32'h0;
      sequence_break_ctr   <= 32'h0;
      received_sequence    <= 72'h0;
      rcv_seq_ctr          <= 4'h0;
      prog_inst_valid      <= 1'b0;
      system_reset_no      <= 1'b0; // eski hali: system_reset_no      <= 1'b1
    end else begin
      case (state_prog)
      SequenceWait: begin
        instruction_byte_ctr <= 4'b0;
        prog_instruction     <= 128'h0;
        prog_intr_number     <= 32'h0;
        prog_intr_ctr        <= 32'h0;
        sequence_break_ctr   <= 32'h0;
        received_sequence    <= 72'h0;
        rcv_seq_ctr          <= 4'h0;
        prog_inst_valid      <= 1'b0;
        // eski hali: system_reset_no       <= 1'b1;
        if (recv_buf_valid) begin
          rcv_seq_ctr <= rcv_seq_ctr + 4'h1;
          received_sequence <= {received_sequence[PROG_SEQ_LENGTH*8-9:0],recv_buf_data[7:0]};
        end
      end
      SequenceReceive: begin
        if (recv_buf_valid) begin
          received_sequence <= {received_sequence[PROG_SEQ_LENGTH*8-9:0],recv_buf_data[7:0]};
          if (rcv_seq_ctr == PROG_SEQ_LENGTH-1) begin
            rcv_seq_ctr <= 4'h0;
          end else begin
            rcv_seq_ctr <= rcv_seq_ctr + 4'h1;
          end
        end else begin
          if (sequence_break) begin
            sequence_break_ctr <= 32'h0;
            rcv_seq_ctr        <= 4'h0;
          end else begin
            sequence_break_ctr <= sequence_break_ctr + 32'h1;
          end
        end
      end
      SequenceCheck: begin
        instruction_byte_ctr <= 4'b0;
      end
      SequenceLengthCalc: begin
        prog_intr_ctr <= 32'h0;
        if (recv_buf_valid) begin
          prog_intr_number <= {prog_intr_number[3*8-1:0],recv_buf_data[7:0]};
          if (instruction_byte_ctr[1:0] == 2'b11) begin
            instruction_byte_ctr <= 4'b0;
          end else begin
            instruction_byte_ctr <= instruction_byte_ctr + 4'b1;
          end
        end
      end
      SequenceProgram: begin
        if (recv_buf_valid) begin
          prog_instruction <= {prog_instruction[15*8-1:0],recv_buf_data[7:0]};
          if (&instruction_byte_ctr) begin
            instruction_byte_ctr <= 4'b0;
            prog_inst_valid      <= 1'b1;
            prog_intr_ctr        <= prog_intr_ctr + 32'h4;
          end else begin
            instruction_byte_ctr <= instruction_byte_ctr + 4'b1;
            prog_inst_valid      <= 1'b0;
          end
        end else begin
          prog_inst_valid      <= 1'b0;
        end
      end
      SequenceFinish: begin
        system_reset_no <= 1'b1; // eski hali: system_reset_no <= 1'b0
      end
    endcase
    end
  end
  
  always_comb begin
    for (int i = 0; i < 4; i++) begin
      prog_instruction_ordered[32*i+:32] = prog_instruction[32*(3-i)+:32];
    end
  end
  
  assign mem_req   = prog_inst_valid;
  assign mem_addr  = prog_addr;
  assign mem_wdata = prog_instruction_ordered;
  assign mem_wstrb = 16'hFFFF;
  assign mem_we    = 1'b1;

endmodule