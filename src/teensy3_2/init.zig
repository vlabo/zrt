const watchdog = @import("watchdog.zig");
const cpu = @import("mk20dx256.zig");
const interrupt = @import("interrupt.zig");
const config = @import("config.zig");
const systick = @import("systick.zig");

extern fn _eram() void;

extern var _etext: usize;
extern var _sdata: usize;
extern var _edata: usize;

extern var _start_data_flash: usize;
extern var _start_data: usize;
extern var _end_data: usize;

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

pub fn pllInit(comptime prdiv_val: comptime_int, comptime vdiv_val: comptime_int) u32 {
    // check if in FEI mode
    var status = cpu.ClockGenerator.status;
    if (!(((status & cpu.MCG_S_CLKST_MASK) >> cpu.MCG_S_CLKST_SHIFT) == 0 and (status & cpu.MCG_S_IREFST_MASK) != 0 and (status & cpu.MCG_S_PLLST_MASK) == 0)) {
        return 0x1;
    }

    comptime var crystal_val: comptime_int = 16000000;
    var hgo_val: u8 = 0;
    var erefs_val: u8 = 1;

    if ((prdiv_val < 1) or (prdiv_val > 25)) {
        return 0x41;
    }
    if ((vdiv_val < 24) or (vdiv_val > 55)) {
        return 0x42;
    }

    // Check PLL reference clock frequency is within spec.
    comptime var ref_freq: comptime_int = crystal_val / prdiv_val;
    if ((ref_freq < 2000000) or (ref_freq > 4000000)) {
        return 0x43;
    }

    // Check PLL output frequency is within spec.
    comptime var pll_freq: comptime_int = (crystal_val / prdiv_val) * vdiv_val;
    if ((pll_freq < 48000000) or (pll_freq > 100000000)) {
        return 0x45;
    }

    // configure the MCG_C2 register
    // the RANGE value is determined by the external frequency. Since the RANGE parameter affects the FRDIV divide value
    // it still needs to be set correctly even if the oscillator is not being used

    var temp_reg = cpu.ClockGenerator.control2;
    var tmp: u8 = (cpu.MCG_C2_RANGE0_MASK | cpu.MCG_C2_HGO0_MASK | cpu.MCG_C2_EREFS0_MASK);
    temp_reg &= ~tmp; // clear fields before writing new values
    temp_reg |= (cpu.mcg_c2_range0(2) | (hgo_val << cpu.MCG_C2_HGO0_SHIFT) | (erefs_val << cpu.MCG_C2_EREFS0_SHIFT));
    cpu.ClockGenerator.control2 = temp_reg;

    comptime var frdiv_val = 4;

    temp_reg = cpu.ClockGenerator.control1;
    tmp = (cpu.MCG_C1_CLKS_MASK | cpu.MCG_C1_FRDIV_MASK | cpu.MCG_C1_IREFS_MASK);
    temp_reg &= ~tmp; // Clear values in these fields
    temp_reg = cpu.mcg_c1_clks(2) | cpu.mcg_c1_frdiv(frdiv_val); // Set the required CLKS and FRDIV values
    cpu.ClockGenerator.control1 = temp_reg;

    var i: u32 = 0;
    while (i < 10000) : (i += 1) {
        if (cpu.ClockGenerator.status & cpu.MCG_S_OSCINIT0_MASK != 0) {
            break;
        } // jump out early if OSCINIT sets before loop finishes
    }
    if (cpu.ClockGenerator.status & cpu.MCG_S_OSCINIT0_MASK == 0) {
        return 0x23;
    } // check bit is really set and return with error if not set

    i = 0;
    while (i < 10000) : (i += 1) {
        if (((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) >> cpu.MCG_S_CLKST_SHIFT) == 0x2) {
            break;
        } // jump out early if CLKST shows EXT CLK slected before loop finishes
    }
    if (((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) >> cpu.MCG_S_CLKST_SHIFT) != 0x2) {
        return 0x1A;
    } // check EXT CLK is really selected and return with error if not

    cpu.ClockGenerator.control6 |= cpu.MCG_C6_CME0_MASK;

    temp_reg = cpu.ClockGenerator.control5;
    tmp = cpu.MCG_C5_PRDIV0_MASK;
    temp_reg &= ~tmp;
    temp_reg |= cpu.mcg_c5_prdiv0(prdiv_val - 1); //set PLL ref divider
    cpu.ClockGenerator.control5 = temp_reg;

    temp_reg = cpu.ClockGenerator.control6; // store present C6 value
    tmp = cpu.MCG_C6_VDIV0_MASK;
    temp_reg &= ~tmp; // clear VDIV settings
    temp_reg |= cpu.MCG_C6_PLLS_MASK | cpu.mcg_c6_vdiv0(vdiv_val - 24); // write new VDIV and enable PLL
    cpu.ClockGenerator.control6 = temp_reg; // update MCG_C6

    i = 0;
    while (i < 2000) : (i += 1) {
        if (cpu.ClockGenerator.status & cpu.MCG_S_PLLST_MASK != 0) {
            break;
        } // jump out early if PLLST sets before loop finishes
    }
    if (cpu.ClockGenerator.status & cpu.MCG_S_PLLST_MASK == 0) {
        return 0x16;
    } // check bit is really set and return with error if not set

    i = 0;
    while (i < 2000) : (i += 1) {
        if (cpu.ClockGenerator.status & cpu.MCG_S_LOCK0_MASK != 0) {
            break;
        } // jump out early if LOCK sets before loop finishes
    }
    if (cpu.ClockGenerator.status & cpu.MCG_S_LOCK0_MASK == 0) {
        return 0x44;
    } // check bit is really set and return with error if not set

    var prdiv = ((cpu.ClockGenerator.control5 & cpu.MCG_C5_PRDIV0_MASK) + 1);
    var vdiv = ((cpu.ClockGenerator.control6 & cpu.MCG_C6_VDIV0_MASK) + 24);

    tmp = cpu.MCG_C1_CLKS_MASK;
    cpu.ClockGenerator.control1 &= ~tmp;

    i = 0;
    while (i < 2000) : (i += 1) {
        if (((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) >> cpu.MCG_S_CLKST_SHIFT) == 0x3) {
            break;
        } // jump out early if CLKST = 3 before loop finishes
    }
    if (((cpu.ClockGenerator.status & cpu.MCG_S_CLKST_MASK) >> cpu.MCG_S_CLKST_SHIFT) != 0x3) {
        return 0x1B;
    } // check CLKST is set correctly and return with error if not

    var freq: u32 = crystal_val;
    return ((freq / prdiv) * vdiv);
}

fn usbInit() void {
    var freq = pllInit(4, 24);

    if (freq < 100) {
        while (true) {}
    }

    cpu.System.Options2.* |= cpu.SIM_SOPT2_USBSRC_MASK | cpu.SIM_SOPT2_PLLFLLSEL_MASK;
    cpu.System.ClockDevider2.* = cpu.sim_clkdiv2_usbdiv(1);

    cpu.System.ClockGating4.* |= cpu.SIM_SCGC4_USBOTG_MASK;

    cpu.Usb.USBTRC0 |= cpu.USB_USBTRC0_USBRESET_MASK;

    while (cpu.Usb.USBTRC0 & cpu.USB_USBTRC0_USBRESET_MASK != 0) {}
}

pub fn setup() void {
    // The CPU has a watchdog feature which is on by default,
    // so we have to configure it to not have nasty reset-surprises
    // later on.

    // There is a write-once-after-reset register that allows to
    // set which power states are available. Let's set it here.
    if (cpu.RegolatorStatusAndControl.* & cpu.PMC_REGSC_ACKISO_MASK != 0) {
        cpu.RegolatorStatusAndControl.* |= cpu.PMC_REGSC_ACKISO_MASK;
    }

    // For the sake of simplicity, enable all GPIO port clocks
    cpu.System.ClockGating5.* |= (cpu.SIM_SCGC5_PORTA_MASK | cpu.SIM_SCGC5_PORTB_MASK | cpu.SIM_SCGC5_PORTC_MASK | cpu.SIM_SCGC5_PORTD_MASK | cpu.SIM_SCGC5_PORTE_MASK);

    cpu.System.ClockDevider1.* = (0 | cpu.sim_clkdiv1_outdiv1(0) | cpu.sim_clkdiv1_outdiv2(1) | cpu.sim_clkdiv1_outdiv4(2));

    usbInit();
}

extern fn zrtMain() noreturn;

export fn _start() linksection(".startup") noreturn {
    watchdog.disable();
    var bss = @ptrCast([*]u8, &_sbss);
    @memset(bss, 0, @ptrToInt(&_ebss) - @ptrToInt(&_sbss));

    var data_flash = @ptrCast([*]u8, &_start_data_flash);
    var data = @ptrCast([*]u8, &_start_data);
    @memcpy(data, data_flash, @ptrToInt(&_end_data) - @ptrToInt(&_start_data));

    zrtMain();
}
