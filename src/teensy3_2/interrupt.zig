pub export fn isr_panic() void {
    while (true) {}
}

pub export fn isr_ignore() void {}

pub const isr_non_maskable: extern fn () void = isr_panic;
pub const isr_hard_fault: extern fn () void = isr_panic;
pub const isr_memmanage_fault: extern fn () void = isr_panic;
pub const isr_bus_fault: extern fn () void = isr_panic;
pub const isr_usage_fault: extern fn () void = isr_panic;

pub const isr_svcall: extern fn () void = isr_ignore;
pub const isr_debug_monitor: extern fn () void = isr_ignore;

pub const isr_pendablesrvreq: extern fn () void = isr_ignore;
pub const isr_systick: extern fn () void = isr_ignore;
pub const isr_dma_ch0_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch1_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch2_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch3_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch4_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch5_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch6_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch7_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch8_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch9_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch10_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch11_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch12_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch13_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch14_complete: extern fn () void = isr_ignore;
pub const isr_dma_ch15_complete: extern fn () void = isr_ignore;
pub const isr_dma_error: extern fn () void = isr_ignore;

pub const isr_flash_cmd_complete: extern fn () void = isr_ignore;
pub const isr_flash_read_collision: extern fn () void = isr_ignore;
pub const isr_low_voltage_warning: extern fn () void = isr_ignore;
pub const isr_low_voltage_wakeup: extern fn () void = isr_ignore;
pub const isr_wdog_or_emw: extern fn () void = isr_ignore;

pub const isr_i2c0: extern fn () void = isr_ignore;
pub const isr_i2c1: extern fn () void = isr_ignore;
pub const isr_spi0: extern fn () void = isr_ignore;
pub const isr_spi1: extern fn () void = isr_ignore;

pub const isr_can0_or_msg_buf: extern fn () void = isr_ignore;
pub const isr_can0_bus_off: extern fn () void = isr_ignore;
pub const isr_can0_error: extern fn () void = isr_ignore;
pub const isr_can0_transmit_warn: extern fn () void = isr_ignore;
pub const isr_can0_receive_warn: extern fn () void = isr_ignore;
pub const isr_can0_wakeup: extern fn () void = isr_ignore;
pub const isr_i2s0_transmit: extern fn () void = isr_ignore;
pub const isr_i2s0_receive: extern fn () void = isr_ignore;

pub const isr_uart0_lon: extern fn () void = isr_ignore;
pub const isr_uart0_status: extern fn () void = isr_ignore;
pub const isr_uart0_error: extern fn () void = isr_ignore;
pub const isr_uart1_status: extern fn () void = isr_ignore;
pub const isr_uart1_error: extern fn () void = isr_ignore;
pub const isr_uart2_status: extern fn () void = isr_ignore;
pub const isr_uart2_error: extern fn () void = isr_ignore;

pub const isr_adc0: extern fn () void = isr_ignore;
pub const isr_adc1: extern fn () void = isr_ignore;
pub const isr_cmp0: extern fn () void = isr_ignore;
pub const isr_cmp1: extern fn () void = isr_ignore;
pub const isr_cmp2: extern fn () void = isr_ignore;
pub const isr_ftm0: extern fn () void = isr_ignore;
pub const isr_ftm1: extern fn () void = isr_ignore;
pub const isr_ftm2: extern fn () void = isr_ignore;
pub const isr_cmt: extern fn () void = isr_ignore;
pub const isr_rtc_alarm: extern fn () void = isr_ignore;
pub const isr_rtc_seconds: extern fn () void = isr_ignore;
pub const isr_pit_ch0: extern fn () void = isr_ignore;
pub const isr_pit_ch1: extern fn () void = isr_ignore;
pub const isr_pit_ch2: extern fn () void = isr_ignore;
pub const isr_pit_ch3: extern fn () void = isr_ignore;
pub const isr_pdb: extern fn () void = isr_ignore;
pub const isr_usb_otg: extern fn () void = isr_ignore;
pub const isr_usb_charger: extern fn () void = isr_ignore;

pub const isr_dac0: extern fn () void = isr_ignore;

pub const isr_tsi: extern fn () void = isr_ignore;
pub const isr_mcg: extern fn () void = isr_ignore;
pub const isr_lpt: extern fn () void = isr_ignore;

pub const isr_port_a: extern fn () void = isr_ignore;
pub const isr_port_b: extern fn () void = isr_ignore;
pub const isr_port_c: extern fn () void = isr_ignore;
pub const isr_port_d: extern fn () void = isr_ignore;
pub const isr_port_e: extern fn () void = isr_ignore;

pub const isr_software: extern fn () void = isr_ignore;
