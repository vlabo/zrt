const watchdog = @import("watchdog.zig");
const c = @cImport(@cInclude("startup.h"));
const cpu = @import("mk20dx256.zig");
const interrupt = @import("interrupt.zig");
const config = @import("config.zig");
const Systick = @import("systick.zig");

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

    if (cpu.RegolatorStatusAndControl.* & cpu.PMC_REGSC_ACKISO_MASK != 0) {
        cpu.RegolatorStatusAndControl.* |= cpu.PMC_REGSC_ACKISO_MASK;
    }

    // For the sake of simplicity, enable all GPIO port clocks
    cpu.System.ClockGating5.* |= (cpu.SIM_SCGC5_PORTA_MASK | cpu.SIM_SCGC5_PORTB_MASK | cpu.SIM_SCGC5_PORTC_MASK | cpu.SIM_SCGC5_PORTD_MASK | cpu.SIM_SCGC5_PORTE_MASK);

    // ----------------------------------------------------------------------------------
    // Setup clocks
    // ----------------------------------------------------------------------------------
    // See section 5 in the Freescale K20 manual for how clock distribution works
    // The limits are outlined in section 5.5:
    //   Core and System clocks: max 72 MHz
    //   Bus/peripherial clock:  max 50 MHz (integer divide of core)
    //   Flash clock:            max 25 MHz
    //
    // The teensy 3.x has a 16 MHz external oscillator
    // So we'll enable the external clock for the OSC module. Since
    // we're in high-frequency mode, also enable capacitors
    cpu.OscillatorControl.* = cpu.OSC_CR_SC8P_MASK | cpu.OSC_CR_SC2P_MASK; // TODO This does not actually seem enable the ext crystal

    // Set MCG to very high frequency crystal and request oscillator. We have
    // to do this first so that the divisor will be correct (512 and not 16)
    cpu.ClockGenerator.control2 = cpu.mcg_c2_range0(2) | cpu.MCG_C2_EREFS0_MASK;

    // Select the external reference clock for MCGOUTCLK
    // The divider for the FLL has to be chosen that we get something in 31.25 to 39.0625 kHz
    // 16MHz / 512 = 31.25 kHz -> set FRDIV to 4
    cpu.ClockGenerator.control1 = cpu.mcg_c1_clks(2) | cpu.mcg_c1_frdiv(4);

    // Wait for OSC to become ready
    while ((cpu.ClockGenerator.status & cpu.MCG_S_OSCINIT0_MASK) == 0) {}

    // Wait for the FLL to synchronize to external reference
    while ((cpu.ClockGenerator.status & cpu.MCG_S_IREFST_MASK) != 0) {}

    // Wait for the clock mode to synchronize to external
    while ((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) != cpu.mcg_s_clkst(2)) {}

    switch (config.frequency) {
        config.CpuFrequency.F16MHz => {
            cpu.ClockGenerator.control2 = cpu.mcg_c2_range0(2) | cpu.MCG_C2_EREFS_MASK | cpu.MCG_C2_LP_MASK;
        },
        config.CpuFrequency.F24MHz => {
            cpu.ClockGenerator.control5 = cpu.mcg_c5_prdiv0(7); // 16 MHz / 8 = 2 MHz (this needs to be 2-4MHz)
            cpu.ClockGenerator.control6 = cpu.MCG_C6_PLLS_MASK | cpu.mcg_c6_vdiv0(0); // Enable PLL*24 = 48 MHz
        },
        config.CpuFrequency.F48MHz => {
            cpu.ClockGenerator.control5 = cpu.mcg_c5_prdiv0(7); // 16 MHz / 8 = 2 MHz (this needs to be 2-4MHz)
            cpu.ClockGenerator.control6 = cpu.MCG_C6_PLLS_MASK | cpu.mcg_c6_vdiv0(0); // Enable PLL*24 = 48 MHz
        },
        config.CpuFrequency.F72MHz => {
            cpu.ClockGenerator.control5 = cpu.mcg_c5_prdiv0(5); // 16 MHz / 6 = 2.66 MHz (this needs to be 2-4MHz)
            cpu.ClockGenerator.control6 = cpu.MCG_C6_PLLS_MASK | cpu.mcg_c6_vdiv0(3); // Enable PLL*27 = 71.82 MHz
        },
        config.CpuFrequency.F96MHz => {
            cpu.ClockGenerator.control5 = cpu.mcg_c5_prdiv0(3); // 16MHz / 4 = 4MHz (this needs to be 2-4MHz)
            cpu.ClockGenerator.control6 = cpu.MCG_C6_PLLS_MASK | cpu.mcg_c6_vdiv0(0); // Enable PLL*24 = 96 MHz
        },
    }

    // Now that we setup and enabled the PLL, wait for it to become active
    while ((cpu.ClockGenerator.status & cpu.MCG_S_PLLST_MASK) == 1) {}
    // and locked
    while ((cpu.ClockGenerator.status & cpu.MCG_S_LOCK0_MASK) == 1) {}

    // -- For the modes <= 16 MHz, we have the MCG clock on 16 MHz, without FLL/PLL
    //    Also, USB is not possible

    switch (config.frequency) {
        config.CpuFrequency.F16MHz => {
            // 16 MHz core, 16 MHz bus, 16 MHz flash
            cpu.System.ClockDevider1.* = cpu.sim_clkdiv1_outdiv1(0) | cpu.sim_clkdiv1_outdiv2(0) | cpu.sim_clkdiv1_outdiv4(0);
        },
        config.CpuFrequency.F24MHz => {
            // PLL is 48 MHz
            // 24 MHz core, 24 MHz bus, 24 MHz flash
            cpu.System.ClockDevider1.* = cpu.sim_clkdiv1_outdiv1(1) | cpu.sim_clkdiv1_outdiv2(1) | cpu.sim_clkdiv1_outdiv4(1);
            cpu.System.ClockDevider2.* = cpu.sim_clkdiv2_usbdiv(0); // 48 * 1/1 = 48
        },
        config.CpuFrequency.F48MHz => {
            // 48 MHz core, 48 MHz bus, 24 MHz flash, USB = 96 / 2
            cpu.System.ClockDevider1.* = cpu.sim_clkdiv1_outdiv1(0) | cpu.sim_clkdiv1_outdiv2(0) | cpu.sim_clkdiv1_outdiv4(1);
            cpu.System.ClockDevider2.* = cpu.sim_clkdiv2_usbdiv(0); // 48 * 1/1 = 48
        },
        config.CpuFrequency.F72MHz => {
            // 72 MHz core, 36 MHz bus, 24 MHz flash
            cpu.System.ClockDevider1.* = cpu.sim_clkdiv1_outdiv1(0) | cpu.sim_clkdiv1_outdiv2(1) | cpu.sim_clkdiv1_outdiv4(2);
            cpu.System.ClockDevider2.* = cpu.sim_clkdiv2_usbdiv(2) | cpu.SIM_CLKDIV2_USBFRAC_MASK; // 72 * 2/3 = 48
        },
        config.CpuFrequency.F96MHz => {
            // 96 MHz core, 48 MHz bus, 24 MHz flash (OVERCLOCKED!)
            cpu.System.ClockDevider1.* = cpu.sim_clkdiv1_outdiv1(0) | cpu.sim_clkdiv1_outdiv2(1) | cpu.sim_clkdiv1_outdiv4(3);
            cpu.System.ClockDevider2.* = cpu.sim_clkdiv2_usbdiv(1); // 96 * 1/2 = 48
        },
    }

    if (config.frequency != config.CpuFrequency.F16MHz) {
        // Switch clock source to PLL, keep FLL divider at 512
        cpu.ClockGenerator.control1 = cpu.mcg_c1_clks(0) | cpu.mcg_c1_frdiv(4);

        // Wait for the clock to sync
        while ((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) != cpu.mcg_s_clkst(3)) {}

        // Use PLL for USB and Bus/peripherals, core for trace and put OSCERCLK0 on CLKOUT pin
        cpu.System.Options2.* = cpu.SIM_SOPT2_USBSRC_MASK | cpu.SIM_SOPT2_PLLFLLSEL_MASK | cpu.SIM_SOPT2_TRACECLKSEL_MASK | cpu.sim_sopt2_clkoutsel(6);
    }

    var bss = @ptrCast([*]u8, &_sbss);
    @memset(bss, 0, @ptrToInt(&_ebss) - @ptrToInt(&_sbss));

    Systick.init();

    interrupt.interrupt_enable();
}


extern fn zrtMain() noreturn;

export fn _start() linksection(".startup") noreturn {
    zrtMain();
}