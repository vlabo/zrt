pub const PORT_PCR_MUX_SHIFT = 8;
pub const PORT_PCR_MUX_MASK = 0x700;

pub const UART_BDH_SBR_SHIFT = 0;
pub const UART_BDH_SBR_MASK = 0x1F;

pub const UART_BDL_SBR_MASK = 0xFF;
pub const UART_BDL_SBR_SHIFT = 0;

pub const UART_C4_BRFA_MASK = 0x1F;
pub const UART_C4_BRFA_SHIFT = 0;

pub const UART_S1_TDRE_MASK = 0x80;

pub const UART_C2_TE_MASK = 0x8;

pub const PORT_PCR_SRE_MASK = 0x4;
pub const PORT_PCR_DSE_MASK = 0x40;

pub const WDOG_UNLOCK_SEQ2 = 0xD928;
pub const WDOG_UNLOCK_SEQ1 = 0xC520;
pub const WDOG_STCTRLH_ALLOWUPDATE_MASK = 0x10;

pub const PMC_REGSC_BGBE_MASK = 0x1;
pub const PMC_REGSC_BGBE_SHIFT = 0;
pub const PMC_REGSC_REGONS_MASK = 0x4;
pub const PMC_REGSC_REGONS_SHIFT = 2;
pub const PMC_REGSC_ACKISO_MASK = 0x8;
pub const PMC_REGSC_ACKISO_SHIFT = 3;
pub const PMC_REGSC_BGEN_MASK = 0x10;
pub const PMC_REGSC_BGEN_SHIFT = 4;

// SCGC1 Bit Fields
pub const SIM_SCGC1_UART4_MASK = 0x400;
pub const SIM_SCGC1_UART4_SHIFT = 10;
// SCGC2 Bit Fields
pub const SIM_SCGC2_DAC0_MASK = 0x1000;
pub const SIM_SCGC2_DAC0_SHIFT = 12;
// SCGC3 Bit Fields
pub const SIM_SCGC3_FTM2_MASK = 0x1000000;
pub const SIM_SCGC3_FTM2_SHIFT = 24;
pub const SIM_SCGC3_ADC1_MASK = 0x8000000;
pub const SIM_SCGC3_ADC1_SHIFT = 27;
// SCGC4 Bit Fields
pub const SIM_SCGC4_EWM_MASK = 0x2;
pub const SIM_SCGC4_EWM_SHIFT = 1;
pub const SIM_SCGC4_CMT_MASK = 0x4;
pub const SIM_SCGC4_CMT_SHIFT = 2;
pub const SIM_SCGC4_I2C0_MASK = 0x40;
pub const SIM_SCGC4_I2C0_SHIFT = 6;
pub const SIM_SCGC4_I2C1_MASK = 0x80;
pub const SIM_SCGC4_I2C1_SHIFT = 7;
pub const SIM_SCGC4_UART0_MASK = 0x400;
pub const SIM_SCGC4_UART0_SHIFT = 10;
pub const SIM_SCGC4_UART1_MASK = 0x800;
pub const SIM_SCGC4_UART1_SHIFT = 11;
pub const SIM_SCGC4_UART2_MASK = 0x1000;
pub const SIM_SCGC4_UART2_SHIFT = 12;
pub const SIM_SCGC4_UART3_MASK = 0x2000;
pub const SIM_SCGC4_UART3_SHIFT = 13;
pub const SIM_SCGC4_USBOTG_MASK = 0x40000;
pub const SIM_SCGC4_USBOTG_SHIFT = 18;
pub const SIM_SCGC4_CMP_MASK = 0x80000;
pub const SIM_SCGC4_CMP_SHIFT = 19;
pub const SIM_SCGC4_VREF_MASK = 0x100000;
pub const SIM_SCGC4_VREF_SHIFT = 20;
// SCGC5 Bit Fields
pub const SIM_SCGC5_LPTIMER_MASK = 0x1;
pub const SIM_SCGC5_LPTIMER_SHIFT = 0;
pub const SIM_SCGC5_TSI_MASK = 0x20;
pub const SIM_SCGC5_TSI_SHIFT = 5;
pub const SIM_SCGC5_PORTA_MASK = 0x200;
pub const SIM_SCGC5_PORTA_SHIFT = 9;
pub const SIM_SCGC5_PORTB_MASK = 0x400;
pub const SIM_SCGC5_PORTB_SHIFT = 10;
pub const SIM_SCGC5_PORTC_MASK = 0x800;
pub const SIM_SCGC5_PORTC_SHIFT = 11;
pub const SIM_SCGC5_PORTD_MASK = 0x1000;
pub const SIM_SCGC5_PORTD_SHIFT = 12;
pub const SIM_SCGC5_PORTE_MASK = 0x2000;
pub const SIM_SCGC5_PORTE_SHIFT = 13;
// SCGC6 Bit Fields
pub const SIM_SCGC6_FTFL_MASK = 0x1;
pub const SIM_SCGC6_FTFL_SHIFT = 0;
pub const SIM_SCGC6_DMAMUX_MASK = 0x2;
pub const SIM_SCGC6_DMAMUX_SHIFT = 1;
pub const SIM_SCGC6_FLEXCAN0_MASK = 0x10;
pub const SIM_SCGC6_FLEXCAN0_SHIFT = 4;
pub const SIM_SCGC6_SPI0_MASK = 0x1000;
pub const SIM_SCGC6_SPI0_SHIFT = 12;
pub const SIM_SCGC6_SPI1_MASK = 0x2000;
pub const SIM_SCGC6_SPI1_SHIFT = 13;
pub const SIM_SCGC6_I2S_MASK = 0x8000;
pub const SIM_SCGC6_I2S_SHIFT = 15;
pub const SIM_SCGC6_CRC_MASK = 0x40000;
pub const SIM_SCGC6_CRC_SHIFT = 18;
pub const SIM_SCGC6_USBDCD_MASK = 0x200000;
pub const SIM_SCGC6_USBDCD_SHIFT = 21;
pub const SIM_SCGC6_PDB_MASK = 0x400000;
pub const SIM_SCGC6_PDB_SHIFT = 22;
pub const SIM_SCGC6_PIT_MASK = 0x800000;
pub const SIM_SCGC6_PIT_SHIFT = 23;
pub const SIM_SCGC6_FTM0_MASK = 0x1000000;
pub const SIM_SCGC6_FTM0_SHIFT = 24;
pub const SIM_SCGC6_FTM1_MASK = 0x2000000;
pub const SIM_SCGC6_FTM1_SHIFT = 25;
pub const SIM_SCGC6_ADC0_MASK = 0x8000000;
pub const SIM_SCGC6_ADC0_SHIFT = 27;
pub const SIM_SCGC6_RTC_MASK = 0x20000000;
pub const SIM_SCGC6_RTC_SHIFT = 29;
// SCGC7 Bit Fields
pub const SIM_SCGC7_FLEXBUS_MASK = 0x1;
pub const SIM_SCGC7_FLEXBUS_SHIFT = 0;
pub const SIM_SCGC7_DMA_MASK = 0x2;
pub const SIM_SCGC7_DMA_SHIFT = 1;

// Addresses
pub const PORTB_PCR16_ADDR = 0x4004A040;
pub const PORTB_PCR17_ADDR = 0x4004A044;

pub const SIM_SCGC4_ADDR = 0x40048034;

pub const GPIOC_PSOR_ADDR = 0x400FF084;
pub const GPIOC_PCOR_ADDR = 0x400FF088;

pub const GPIOC_PDDR_ADDR = 0x400FF094;
pub const PORTC_PCR_ADDR = 0x4004B000;

pub const UART0_BASE_ADDR = 0x4006A000;

pub const WDOG_UNLOCK_ADDR = 0x4005200E;
pub const WDOG_STCTRLH_ADDR = 0x40052000;

pub const PMC_REGSC_ADDR = 0x4007D002; // 8 bit

pub const SMC_PMPROT_ADDR = 0x4007E000;

pub const SIM_SCGC5_ADDR = 0x40048038;

pub fn port_pcr_mux(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, PORT_PCR_MUX_SHIFT, PORT_PCR_MUX_MASK);
}

pub fn uart_bdh_sbr(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, UART_BDH_SBR_SHIFT, UART_BDH_SBR_MASK);
}

pub fn uart_bdl_sbr(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, UART_BDL_SBR_SHIFT, UART_BDL_SBR_MASK);
}

pub fn uart_c4_brfa(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, UART_C4_BRFA_SHIFT, UART_C4_BRFA_MASK);
}

fn left_shift_and_mask(comptime x: comptime_int, comptime shift: u4, comptime mask: u32) comptime_int {
    return (x << shift) & mask;
}

pub inline fn nop() void {
    asm volatile ("nop");
}
