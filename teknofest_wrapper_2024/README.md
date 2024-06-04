# Teknofest wrapper
- teknofest_wrapper.sv içerisine çekirdeği instantiate edebilirsiniz.
- USE_SRAM paramteresi DDR2 IP (MIG) yerine Block RAM kullanılmasını sağlar.
- UART programlamayı testbenchte denemek için tb_teknofest_wrapper.sv'deki taskları kullanabilirsiniz.
- UART programlama Vivado üzerinde uzun sürüyor. Bu nedenle simülasyonları SRAM ile yapabilirsiniz.

- Karşılaştığınız bug veya özellik ekleme gibi konularda issue'ları kullanabilirsiniz.