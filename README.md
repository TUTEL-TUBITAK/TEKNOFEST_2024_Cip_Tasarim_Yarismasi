# TEKNOFEST Wrapper 2024

- Wrapper ne yapıyor?
Wrapper tasarlanan işlemcinin ana bellek (SRAM veya DRAM) haberleşmesi için kullanılabilecek bir modüldür. Bunun yanında içerisinde UART receiver sayesinde belleği programlamayı sağlamaktadır.

- Tasarladığım işlemciyi nasıl bağlayacağım?
`./teknofest_wrapper_2024.srcs/sources_1/new/teknofest_wrapper.sv` içersisinde işlemcinizi instantiate edin. İşlemcinin clock ve reset sinyalleri sırasıyla `core_clk` ve `core_rst_n` olmaktadır. Ana belleğe giden sinyaller ise `core_mem` struct'ına bağlanmalıdır.

- SRAM ve DRAM kullandığımı nasıl anlayacağım?
Wrapper'ın `USE_SRAM` parametresi 1 olduğunda SRAM, 0 durumunda ise DRAM kullanmaktadır. DRAM Xilinx'in MIG IP'sini kullanmaktadır. 

- Programımı nasıl yükleyeceğim.
`./teknofest_wrapper_2024.srcs/sources_1/new/tb_teknofest_wrapper.sv` dosyasında kullanabileceğiniz yardımcı SV taskları bulunuyor. Öncelikle `boot_program` sinyalini `readmemh` fonksiyonu ile doldurmalısınız. Daha sonrasında `send_program` taskı ile bu program ana belleğe UART ile yazılacaktır. 

Testbencteki `core_write` ve `core_read` taskları sistemi denemek için kullanılmıştır. 


Sorular için issue açabilirsiniz.