const watchdog = @import("watchdog.zig");
const cpu = @import("mk20dx256.zig");
const interrupt = @import("interrupt.zig");
const config = @import("config.zig");
const systick = @import("systick.zig");

extern fn _eram() void;

extern var _etext: usize;
extern var _sdata: usize;
extern var _edata: usize;

extern var _sbss: u8;
extern var _ebss: u8;

export const interrupt_vectors linksection(".vectors") = [_]fn () callconv(.C) void{
    _eram,
    _start,
    interrupt.isr_non_maskable,
    interrupt.isr_hard_fault,
    interrupt.isr_memmanage_fault,
    interrupt.isr_bus_fault,
    interrupt.isr_usage_fault,
    interrupt.isr_ignore, // Reserved 7
    interrupt.isr_ignore, // Reserved 8
    interrupt.isr_ignore, // Reserved 9
    interrupt.isr_ignore, // Reserved 10
    interrupt.isr_svcall,
    interrupt.isr_debug_monitor,
    interrupt.isr_ignore, // Reserved 13
    interrupt.isr_pendablesrvreq,
    interrupt.isr_systick,
    interrupt.isr_dma_ch0_complete,
    interrupt.isr_dma_ch1_complete,
    interrupt.isr_dma_ch2_complete,
    interrupt.isr_dma_ch3_complete,
    interrupt.isr_dma_ch4_complete,
    interrupt.isr_dma_ch5_complete,
    interrupt.isr_dma_ch6_complete,
    interrupt.isr_dma_ch7_complete,
    interrupt.isr_dma_ch8_complete,
    interrupt.isr_dma_ch9_complete,
    interrupt.isr_dma_ch10_complete,
    interrupt.isr_dma_ch11_complete,
    interrupt.isr_dma_ch12_complete,
    interrupt.isr_dma_ch13_complete,
    interrupt.isr_dma_ch14_complete,
    interrupt.isr_dma_ch15_complete,
    interrupt.isr_dma_error,
    interrupt.isr_ignore, // Unused ? INT_MCM ?
    interrupt.isr_flash_cmd_complete,
    interrupt.isr_flash_read_collision,
    interrupt.isr_low_voltage_warning,
    interrupt.isr_low_voltage_wakeup,
    interrupt.isr_wdog_or_emw,
    interrupt.isr_ignore, // Reserved 39
    interrupt.isr_i2c0,
    interrupt.isr_i2c1,
    interrupt.isr_spi0,
    interrupt.isr_spi1,
    interrupt.isr_ignore, // Teensy does not have SPI2
    interrupt.isr_can0_or_msg_buf,
    interrupt.isr_can0_bus_off,
    interrupt.isr_can0_error,
    interrupt.isr_can0_transmit_warn,
    interrupt.isr_can0_receive_warn,
    interrupt.isr_can0_wakeup,
    interrupt.isr_i2s0_transmit,
    interrupt.isr_i2s0_receive,
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Teensy does not have CAN1
    interrupt.isr_ignore, // Reserved 59
    interrupt.isr_uart0_lon,
    interrupt.isr_uart0_status,
    interrupt.isr_uart0_error,
    interrupt.isr_uart1_status,
    interrupt.isr_uart1_error,
    interrupt.isr_uart2_status,
    interrupt.isr_uart2_error,
    interrupt.isr_ignore, // Teensy does not have UART3
    interrupt.isr_ignore, // Teensy does not have UART3
    interrupt.isr_ignore, // Teensy does not have UART4
    interrupt.isr_ignore, // Teensy does not have UART4
    interrupt.isr_ignore, // Teensy does not have UART5
    interrupt.isr_ignore, // Teensy does not have UART5
    interrupt.isr_adc0,
    interrupt.isr_adc1,
    interrupt.isr_cmp0,
    interrupt.isr_cmp1,
    interrupt.isr_cmp2,
    interrupt.isr_ftm0,
    interrupt.isr_ftm1,
    interrupt.isr_ftm2,
    interrupt.isr_cmt,
    interrupt.isr_rtc_alarm,
    interrupt.isr_rtc_seconds,
    interrupt.isr_pit_ch0,
    interrupt.isr_pit_ch1,
    interrupt.isr_pit_ch2,
    interrupt.isr_pit_ch3,
    interrupt.isr_pdb,
    interrupt.isr_usb_otg,
    interrupt.isr_usb_charger,
    interrupt.isr_ignore, // Reserved 91
    interrupt.isr_ignore, // Reserved 92
    interrupt.isr_ignore, // Reserved 93
    interrupt.isr_ignore, // Reserved 94
    interrupt.isr_ignore, // Nothing according to manual, I2S0 according to headers
    interrupt.isr_ignore, // Nothing according to manual, SDHC according to headers
    interrupt.isr_dac0,
    interrupt.isr_ignore, // Teensy does not have DAC1
    interrupt.isr_tsi,
    interrupt.isr_mcg,
    interrupt.isr_lpt,
    interrupt.isr_ignore, // Reserved 102
    interrupt.isr_port_a,
    interrupt.isr_port_b,
    interrupt.isr_port_c,
    interrupt.isr_port_d,
    interrupt.isr_port_e,
    interrupt.isr_ignore, // Reserved 108
    interrupt.isr_ignore, // Reserved 109
    interrupt.isr_software,
    interrupt.isr_ignore, // Reserved 111
};
//  The flash configuration appears at 0x400 and is loaded on boot.
//    The first 8 bytes are the backdoor comparison key.
//    The next 4 bytes are the FPROT registers.
//
//    Then, there's one byte each:
//     FSEC, FOPT, FEPROT, FDPROT
//
//  For most of these fields, 0xFF are the permissive defaults. For
//  FSEC, we'll set SEC to 10 to put the MCU in unsecure mode for
//  unlimited flash access -> 0xFE.
//
export const flashconfigbytes: [16]u8 linksection(".flashconfig") = [_]u8{
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF,
};

pub fn setup() void {

    watchdog.disable();

    var bss = @ptrCast([*]u8, &_sbss);
    @memset(bss, 0, @ptrToInt(&_ebss) - @ptrToInt(&_sbss));

}

extern fn zrtMain() noreturn;

export fn _start() linksection(".startup") noreturn {
    asm volatile (
        \\ mov     r0,#0
        \\ mov     r1,#0
        \\ mov     r2,#0
        \\ mov     r3,#0
        \\ mov     r4,#0
        \\ mov     r5,#0
        \\ mov     r6,#0
        \\ mov     r7,#0
        \\ mov     r8,#0
        \\ mov     r9,#0
        \\ mov     r10,#0
        \\ mov     r11,#0
        \\ mov     r12,#0
    );

    zrtMain();
}
