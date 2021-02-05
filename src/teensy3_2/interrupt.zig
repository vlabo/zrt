const cpu = @import("mk20dx256.zig");

pub fn enable() void {
    asm volatile ("CPSIE i"
        :
        :
        : "memory"
    );
}

pub fn disable() void {
    asm volatile ("CPSID i"
        :
        :
        : "memory"
    );
}

pub fn trigger_pendsv() void {
    cpu.SystemControl.ICSR = 0x10000000;
}

// extern fn xPortPendSVHandler() callconv(.C) void;
// extern fn xPortSysTickHandler() callconv(.C) void;
// extern fn vPortSVCHandler() callconv(.C) void;

extern fn USBOTG_IRQHandler() callconv(.C) void;

pub export fn isr_panic() void {
    while (true) {}
}

pub export fn isr_ignore() void {}

pub const isr_non_maskable: fn () callconv(.C) void = isr_panic;
pub const isr_hard_fault: fn () callconv(.C) void = isr_panic;
pub const isr_memmanage_fault: fn () callconv(.C) void = isr_panic;
pub const isr_bus_fault: fn () callconv(.C) void = isr_panic;
pub const isr_usage_fault: fn () callconv(.C) void = isr_panic;

pub const isr_svcall: fn () callconv(.C) void = isr_ignore;
pub const isr_debug_monitor: fn () callconv(.C) void = isr_ignore;

pub const isr_pendablesrvreq: fn () callconv(.C) void = isr_ignore;
pub const isr_systick: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch0_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch1_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch2_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch3_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch4_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch5_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch6_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch7_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch8_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch9_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch10_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch11_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch12_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch13_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch14_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_ch15_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_dma_error: fn () callconv(.C) void = isr_ignore;

pub const isr_flash_cmd_complete: fn () callconv(.C) void = isr_ignore;
pub const isr_flash_read_collision: fn () callconv(.C) void = isr_ignore;
pub const isr_low_voltage_warning: fn () callconv(.C) void = isr_ignore;
pub const isr_low_voltage_wakeup: fn () callconv(.C) void = isr_ignore;
pub const isr_wdog_or_emw: fn () callconv(.C) void = isr_ignore;

pub const isr_i2c0: fn () callconv(.C) void = isr_ignore;
pub const isr_i2c1: fn () callconv(.C) void = isr_ignore;
pub const isr_spi0: fn () callconv(.C) void = isr_ignore;
pub const isr_spi1: fn () callconv(.C) void = isr_ignore;

pub const isr_can0_or_msg_buf: fn () callconv(.C) void = isr_ignore;
pub const isr_can0_bus_off: fn () callconv(.C) void = isr_ignore;
pub const isr_can0_error: fn () callconv(.C) void = isr_ignore;
pub const isr_can0_transmit_warn: fn () callconv(.C) void = isr_ignore;
pub const isr_can0_receive_warn: fn () callconv(.C) void = isr_ignore;
pub const isr_can0_wakeup: fn () callconv(.C) void = isr_ignore;
pub const isr_i2s0_transmit: fn () callconv(.C) void = isr_ignore;
pub const isr_i2s0_receive: fn () callconv(.C) void = isr_ignore;

pub const isr_uart0_lon: fn () callconv(.C) void = isr_ignore;
pub const isr_uart0_status: fn () callconv(.C) void = isr_ignore;
pub const isr_uart0_error: fn () callconv(.C) void = isr_ignore;
pub const isr_uart1_status: fn () callconv(.C) void = isr_ignore;
pub const isr_uart1_error: fn () callconv(.C) void = isr_ignore;
pub const isr_uart2_status: fn () callconv(.C) void = isr_ignore;
pub const isr_uart2_error: fn () callconv(.C) void = isr_ignore;

pub const isr_adc0: fn () callconv(.C) void = isr_ignore;
pub const isr_adc1: fn () callconv(.C) void = isr_ignore;
pub const isr_cmp0: fn () callconv(.C) void = isr_ignore;
pub const isr_cmp1: fn () callconv(.C) void = isr_ignore;
pub const isr_cmp2: fn () callconv(.C) void = isr_ignore;
pub const isr_ftm0: fn () callconv(.C) void = isr_ignore;
pub const isr_ftm1: fn () callconv(.C) void = isr_ignore;
pub const isr_ftm2: fn () callconv(.C) void = isr_ignore;
pub const isr_cmt: fn () callconv(.C) void = isr_ignore;
pub const isr_rtc_alarm: fn () callconv(.C) void = isr_ignore;
pub const isr_rtc_seconds: fn () callconv(.C) void = isr_ignore;
pub const isr_pit_ch0: fn () callconv(.C) void = isr_ignore;
pub const isr_pit_ch1: fn () callconv(.C) void = isr_ignore;
pub const isr_pit_ch2: fn () callconv(.C) void = isr_ignore;
pub const isr_pit_ch3: fn () callconv(.C) void = isr_ignore;
pub const isr_pdb: fn () callconv(.C) void = isr_ignore;
pub const isr_usb_otg: fn () callconv(.C) void = USBOTG_IRQHandler;
pub const isr_usb_charger: fn () callconv(.C) void = isr_ignore;

pub const isr_dac0: fn () callconv(.C) void = isr_ignore;

pub const isr_tsi: fn () callconv(.C) void = isr_ignore;
pub const isr_mcg: fn () callconv(.C) void = isr_ignore;
pub const isr_lpt: fn () callconv(.C) void = isr_ignore;

pub const isr_port_a: fn () callconv(.C) void = isr_ignore;
pub const isr_port_b: fn () callconv(.C) void = isr_ignore;
pub const isr_port_c: fn () callconv(.C) void = isr_ignore;
pub const isr_port_d: fn () callconv(.C) void = isr_ignore;
pub const isr_port_e: fn () callconv(.C) void = isr_ignore;

pub const isr_software: fn () callconv(.C) void = isr_ignore;
