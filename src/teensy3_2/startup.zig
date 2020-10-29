const watchdog = @import("watchdog.zig");
const c = @cImport(@cInclude("startup.h"));
const cpu = @import("mk20dx256.zig");
const interrupt = @import("interrupt.zig");

var PMC_REGSC = @intToPtr(*volatile u8, cpu.PMC_REGSC_ADDR);
var SIM_SCGC5 = @intToPtr(*volatile u32, cpu.SIM_SCGC5_ADDR);

extern fn _eram() void;
extern fn __startup() void;

export const interrupt_vectors linksection(".vectors") = [_]extern fn () void{
    _eram,
    __startup,
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

pub fn setup() void {
    // The CPU has a watchdog feature which is on by default,
    // so we have to configure it to not have nasty reset-surprises
    // later on.
    watchdog.disable();

    // If the system was in VLLS mode, some peripherials and
    // the I/O pins are in latched mode. We need to restore
    // config and can then acknowledge the isolation to get back
    // to normal. For now, we'll just ack TODO: properly do this
    // if (PMC_REGSC & PMC_REGSC_ACKISO_MASK) PMC_REGSC |= PMC_REGSC_ACKISO_MASK;

    // There is a write-once-after-reset register that allows to
    // set which power states are available. Let's set it here.

    if (PMC_REGSC.* & cpu.PMC_REGSC_ACKISO_MASK != 0) {
        PMC_REGSC.* |= cpu.PMC_REGSC_ACKISO_MASK;
    }

    // For the sake of simplicity, enable all GPIO port clocks
    SIM_SCGC5.* |= (cpu.SIM_SCGC5_PORTA_MASK | cpu.SIM_SCGC5_PORTB_MASK | cpu.SIM_SCGC5_PORTC_MASK | cpu.SIM_SCGC5_PORTD_MASK | cpu.SIM_SCGC5_PORTE_MASK);

    c.c_startup();
}
