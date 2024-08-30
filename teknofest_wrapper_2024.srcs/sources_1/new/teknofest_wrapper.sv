`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:     TUBITAK - TUTEL
// Project:     TEKNOFEST CIP TASARIM YARISMASI
// Engineer:    -
// Version:     1.0
//*************************************************************************************************************************************************//
// Create Date: 
// Module Name: teknofest_wrapper
//
// Description: 
//
//*************************************************************************************************************************************************//
// Copyright 2024 TUTEL (IC Design and Training Laboratory - TUBITAK).
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module teknofest_wrapper #(
    parameter USE_SRAM  = 0,
    parameter DDR_FREQ_HZ = 300_000_000,
    parameter UART_BAUD_RATE = 9600
)(
    // Related to DDR MIG
    input logic sys_rst_n,
    input logic sys_clk, // TODO: SRAM kullan?rken bunu cpu clock olarak kullan, yoksa DDR ui_clk
    
    input logic ram_prog_rx_i,
   
    output logic       core_clk,
    output logic       core_rst_n,
    
    inout  [15:0] ddr2_dq,
    inout  [1:0]  ddr2_dqs_n,
    inout  [1:0]  ddr2_dqs_p,
    output [12:0] ddr2_addr,
    output [2:0]  ddr2_ba,
    output        ddr2_ras_n,
    output        ddr2_cas_n,
    output        ddr2_we_n,
    output        ddr2_reset_n,
    output        ddr2_ck_p,
    output        ddr2_ck_n,
    output        ddr2_cke,
    output        ddr2_cs_n,
    inout  [1:0]  ddr2_dm,
    output        ddr2_odt
);

    localparam CPU_FREQ_HZ = DDR_FREQ_HZ / 4; // MIG is configured 1:4
        
    typedef struct packed {
        logic         valid;
        logic [31:0]  addr;
        logic [127:0] wdata;
        logic [15:0]  wstrb;
        logic         we;
    } mem_req_t;
    
    typedef struct packed {
        logic [127:0] rdata;
        logic         rvalid;
        logic         ready;
    } mem_resp_t;

    typedef struct packed {
        mem_req_t    req;
        mem_resp_t   resp;
    } mem_t;
    
    mem_t core_mem, programmer_mem, sel_mem;
    
    logic system_reset_n;
    logic programmer_active;
    logic ui_clk, ui_rst_n;
    logic init_calib_complete;
    
    assign core_clk = USE_SRAM ? sys_clk : ui_clk;
    assign core_rst_n = system_reset_n && (USE_SRAM ? sys_rst_n : ui_rst_n);
    
    // Core'u burada cagirin. core_mem struct'?n? ba?lay?n.
    // core_clk ve core_rst_n sinyallerini baglamayi unutmayin.
       
    programmer #(
        .UART_BAUD_RATE(UART_BAUD_RATE),
        .CPU_FREQ_HZ   (CPU_FREQ_HZ),
        .mem_req_t     (mem_req_t)
    )u_programmer (
        .clk                    (core_clk),
        .rst_n                  (core_rst_n),
        .mem_req_o              (programmer_mem.req),
        .mem_ready              (programmer_mem.resp.ready),
        .ram_prog_rx_i          (ram_prog_rx_i),
        .system_reset_no        (system_reset_n),
        .programming_active     (programmer_active)
    );
    
    assign sel_mem.req = programmer_active ? programmer_mem.req : core_mem.req;
       
    assign programmer_mem.resp.rvalid = 1'b0;
    assign programmer_mem.resp.rdata  = '0;
    assign programmer_mem.resp.ready  = sel_mem.resp.ready && init_calib_complete;
    
    assign core_mem.resp.rvalid = ~programmer_active && sel_mem.resp.rvalid;
    assign core_mem.resp.rdata  = {128{~programmer_active}} & sel_mem.resp.rdata;
    assign core_mem.resp.ready  = sel_mem.resp.ready && init_calib_complete;
    
    teknofest_memory #(
        .USE_SRAM   (USE_SRAM),
        .MEM_DEPTH  (16)
    )u_teknofest_memory(
        .clk_i               (sys_clk),
        .rst_ni              (sys_rst_n),
        .req                 (sel_mem.req.valid   ),
        .ready               (sel_mem.resp.ready ),
        .we                  (sel_mem.req.we    ),
        .addr                (sel_mem.req.addr  ),
        .wdata               (sel_mem.req.wdata ),
        .wstrb               (sel_mem.req.wstrb ),
        .rdata               (sel_mem.resp.rdata ),
        .rvalid              (sel_mem.resp.rvalid),
        .sys_rst             (sys_rst_n),
        .sys_clk             (sys_clk),
        .ui_clk              (ui_clk),
        .ui_rst_n            (ui_rst_n),
        .init_calib_complete (init_calib_complete),
        .ddr2_dq             (ddr2_dq),     
        .ddr2_dqs_n          (ddr2_dqs_n),  
        .ddr2_dqs_p          (ddr2_dqs_p),  
        .ddr2_addr           (ddr2_addr),   
        .ddr2_ba             (ddr2_ba),     
        .ddr2_ras_n          (ddr2_ras_n),  
        .ddr2_cas_n          (ddr2_cas_n),  
        .ddr2_we_n           (ddr2_we_n),   
        .ddr2_reset_n        (ddr2_reset_n),
        .ddr2_ck_p           (ddr2_ck_p),   
        .ddr2_ck_n           (ddr2_ck_n),   
        .ddr2_cke            (ddr2_cke),    
        .ddr2_cs_n           (ddr2_cs_n),   
        .ddr2_dm             (ddr2_dm),     
        .ddr2_odt            (ddr2_odt)     
    );
    
    
   

endmodule