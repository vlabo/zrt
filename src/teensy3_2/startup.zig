const watchdog = @import("watchdog.zig");
const c = @cImport(@cInclude("startup.h"));
const cpu = @import("mk20dx256.zig");

var PMC_REGSC = @intToPtr(*volatile u8, cpu.PMC_REGSC_ADDR);
var SIM_SCGC5 = @intToPtr(*volatile u32, cpu.SIM_SCGC5_ADDR);


extern fn _eram() void;
extern const _etext: usize;
extern const _sdata: usize;
extern const _edata: usize;
extern const _sbss: usize;
extern const _ebss: usize;

extern fn __startup() void;

export const interrupt_vectors linksection(".vectors") = [_]extern fn () void {
     _eram,
     __startup

     // TODO: add all interupts from C
     };
// {
//   (void (*)(void))((unsigned long)&_eram),
//   __startup,
//   isr_non_maskable,
//   isr_hard_fault,
//   isr_memmanage_fault,
//   isr_bus_fault,
//   isr_usage_fault,
//   isr_ignore,  // Reserved 7
//   isr_ignore,  // Reserved 8
//   isr_ignore,  // Reserved 9
//   isr_ignore,  // Reserved 10
//   isr_svcall,
//   isr_debug_monitor,
//   isr_ignore,  // Reserved 13
//   isr_pendablesrvreq,
//   isr_systick,
//   isr_dma_ch0_complete,
//   isr_dma_ch1_complete,
//   isr_dma_ch2_complete,
//   isr_dma_ch3_complete,
//   isr_dma_ch4_complete,
//   isr_dma_ch5_complete,
//   isr_dma_ch6_complete,
//   isr_dma_ch7_complete,
//   isr_dma_ch8_complete,
//   isr_dma_ch9_complete,
//   isr_dma_ch10_complete,
//   isr_dma_ch11_complete,
//   isr_dma_ch12_complete,
//   isr_dma_ch13_complete,
//   isr_dma_ch14_complete,
//   isr_dma_ch15_complete,
//   isr_dma_error,
//   isr_ignore, // Unused ? INT_MCM ?
//   isr_flash_cmd_complete,
//   isr_flash_read_collision,
//   isr_low_voltage_warning,
//   isr_low_voltage_wakeup,
//   isr_wdog_or_emw,
//   isr_ignore, // Reserved 39
//   isr_i2c0,
//   isr_i2c1,
//   isr_spi0,
//   isr_spi1,
//   isr_ignore, // Teensy does not have SPI2
//   isr_can0_or_msg_buf,
//   isr_can0_bus_off,
//   isr_can0_error,
//   isr_can0_transmit_warn,
//   isr_can0_receive_warn,
//   isr_can0_wakeup,
//   isr_i2s0_transmit,
//   isr_i2s0_receive,
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Teensy does not have CAN1
//   isr_ignore, // Reserved 59
//   isr_uart0_lon,
//   isr_uart0_status,
//   isr_uart0_error,
//   isr_uart1_status,
//   isr_uart1_error,
//   isr_uart2_status,
//   isr_uart2_error,
//   isr_ignore, // Teensy does not have UART3
//   isr_ignore, // Teensy does not have UART3
//   isr_ignore, // Teensy does not have UART4
//   isr_ignore, // Teensy does not have UART4
//   isr_ignore, // Teensy does not have UART5
//   isr_ignore, // Teensy does not have UART5
//   isr_adc0,
//   isr_adc1,
//   isr_cmp0,
//   isr_cmp1,
//   isr_cmp2,
//   isr_ftm0,
//   isr_ftm1,
//   isr_ftm2,
//   isr_cmt,
//   isr_rtc_alarm,
//   isr_rtc_seconds,
//   isr_pit_ch0,
//   isr_pit_ch1,
//   isr_pit_ch2,
//   isr_pit_ch3,
//   isr_pdb,
//   isr_usb_otg,
//   isr_usb_charger,
//   isr_ignore, // Reserved 91
//   isr_ignore, // Reserved 92
//   isr_ignore, // Reserved 93
//   isr_ignore, // Reserved 94
//   isr_ignore, // Nothing according to manual, I2S0 according to headers
//   isr_ignore, // Nothing according to manual, SDHC according to headers
//   isr_dac0,
//   isr_ignore, // Teensy does not have DAC1
//   isr_tsi,
//   isr_mcg,
//   isr_lpt,
//   isr_ignore, // Reserved 102
//   isr_port_a,
//   isr_port_b,
//   isr_port_c,
//   isr_port_d,
//   isr_port_e,
//   isr_ignore, // Reserved 108
//   isr_ignore, // Reserved 109
//   isr_software,
//   isr_ignore  // Reserved 111
// };


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
