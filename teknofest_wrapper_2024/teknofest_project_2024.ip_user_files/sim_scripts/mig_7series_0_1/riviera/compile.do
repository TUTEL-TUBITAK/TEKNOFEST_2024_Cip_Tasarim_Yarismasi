transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/fatih/teknofest_project_2024/teknofest_project_2024.cache/compile_simlib/riviera}
vlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 -l xil_defaultlib \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_2_clk_ibuf.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_2_infrastructure.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_2_iodelay_ctrl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_2_tempmon.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_arb_mux.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_arb_row_col.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_arb_select.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_cntrl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_common.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_compare.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_mach.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_queue.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_bank_state.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_col_mach.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_mc.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_rank_cntrl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_rank_common.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_rank_mach.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/controller/mig_7series_v4_2_round_robin_arb.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_2_ecc_buf.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_2_ecc_dec_fix.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_2_ecc_gen.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_2_ecc_merge_enc.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_2_fi_xor.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ip_top/mig_7series_v4_2_memc_ui_top_std.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ip_top/mig_7series_v4_2_mem_intfc.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_group_io.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_lane.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_calib_top.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_if_post_fifo.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy_wrapper.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_of_pre_fifo.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_4lanes.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal_hr.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_init.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_cntlr.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_data.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_edge.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_lim.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_mux.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_po_cntlr.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_samp.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_oclkdelay_cal.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_prbs_rdlvl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_rdlvl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_tempmon.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_top.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrcal.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl_off_delay.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_ddr_prbs_gen.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_cc.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_edge_store.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_meta.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_pd.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_tap_base.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/phy/mig_7series_v4_2_poc_top.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ui/mig_7series_v4_2_ui_cmd.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ui/mig_7series_v4_2_ui_rd_data.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ui/mig_7series_v4_2_ui_top.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/ui/mig_7series_v4_2_ui_wr_data.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/mig_7series_0_mig_sim.v" \
"../../../../teknofest_project_2024.gen/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/rtl/mig_7series_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

