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

// SOPT1 Bit Fields
pub const SIM_SOPT1_RAMSIZE_MASK = 0xF000;
pub const SIM_SOPT1_RAMSIZE_SHIFT = 12;
pub const SIM_SOPT1_OSC32KSEL_MASK = 0xC0000;
pub const SIM_SOPT1_OSC32KSEL_SHIFT = 18;
pub const SIM_SOPT1_USBVSTBY_MASK = 0x20000000;
pub const SIM_SOPT1_USBVSTBY_SHIFT = 29;
pub const SIM_SOPT1_USBSSTBY_MASK = 0x40000000;
pub const SIM_SOPT1_USBSSTBY_SHIFT = 30;
pub const SIM_SOPT1_USBREGEN_MASK = 0x80000000;
pub const SIM_SOPT1_USBREGEN_SHIFT = 31;

// SOPT1CFG Bit Fields
pub const SIM_SOPT1CFG_URWE_MASK = 0x1000000;
pub const SIM_SOPT1CFG_URWE_SHIFT = 24;
pub const SIM_SOPT1CFG_UVSWE_MASK = 0x2000000;
pub const SIM_SOPT1CFG_UVSWE_SHIFT = 25;
pub const SIM_SOPT1CFG_USSWE_MASK = 0x4000000;
pub const SIM_SOPT1CFG_USSWE_SHIFT = 26;
// SOPT2 Bit Fields
pub const SIM_SOPT2_RTCCLKOUTSEL_MASK = 0x10;
pub const SIM_SOPT2_RTCCLKOUTSEL_SHIFT = 4;
pub const SIM_SOPT2_CLKOUTSEL_MASK = 0xE0;
pub const SIM_SOPT2_CLKOUTSEL_SHIFT = 5;
pub const SIM_SOPT2_FBSL_MASK = 0x300;
pub const SIM_SOPT2_FBSL_SHIFT = 8;
pub const SIM_SOPT2_PTD7PAD_MASK = 0x800;
pub const SIM_SOPT2_PTD7PAD_SHIFT = 11;
pub const SIM_SOPT2_TRACECLKSEL_MASK = 0x1000;
pub const SIM_SOPT2_TRACECLKSEL_SHIFT = 12;
pub const SIM_SOPT2_PLLFLLSEL_MASK = 0x10000;
pub const SIM_SOPT2_PLLFLLSEL_SHIFT = 16;
pub const SIM_SOPT2_USBSRC_MASK = 0x40000;
pub const SIM_SOPT2_USBSRC_SHIFT = 18;

// SOPT4 Bit Fields
pub const SIM_SOPT4_FTM0FLT0_MASK = 0x1;
pub const SIM_SOPT4_FTM0FLT0_SHIFT = 0;
pub const SIM_SOPT4_FTM0FLT1_MASK = 0x2;
pub const SIM_SOPT4_FTM0FLT1_SHIFT = 1;
pub const SIM_SOPT4_FTM0FLT2_MASK = 0x4;
pub const SIM_SOPT4_FTM0FLT2_SHIFT = 2;
pub const SIM_SOPT4_FTM1FLT0_MASK = 0x10;
pub const SIM_SOPT4_FTM1FLT0_SHIFT = 4;
pub const SIM_SOPT4_FTM2FLT0_MASK = 0x100;
pub const SIM_SOPT4_FTM2FLT0_SHIFT = 8;
pub const SIM_SOPT4_FTM1CH0SRC_MASK = 0xC0000;
pub const SIM_SOPT4_FTM1CH0SRC_SHIFT = 18;
pub const SIM_SOPT4_FTM2CH0SRC_MASK = 0x300000;
pub const SIM_SOPT4_FTM2CH0SRC_SHIFT = 20;
pub const SIM_SOPT4_FTM0CLKSEL_MASK = 0x1000000;
pub const SIM_SOPT4_FTM0CLKSEL_SHIFT = 24;
pub const SIM_SOPT4_FTM1CLKSEL_MASK = 0x2000000;
pub const SIM_SOPT4_FTM1CLKSEL_SHIFT = 25;
pub const SIM_SOPT4_FTM2CLKSEL_MASK = 0x4000000;
pub const SIM_SOPT4_FTM2CLKSEL_SHIFT = 26;
pub const SIM_SOPT4_FTM0TRG0SRC_MASK = 0x10000000;
pub const SIM_SOPT4_FTM0TRG0SRC_SHIFT = 28;
pub const SIM_SOPT4_FTM0TRG1SRC_MASK = 0x20000000;
pub const SIM_SOPT4_FTM0TRG1SRC_SHIFT = 29;

// SOPT5 Bit Fields
pub const SIM_SOPT5_UART0TXSRC_MASK = 0x3;
pub const SIM_SOPT5_UART0TXSRC_SHIFT = 0;
pub const SIM_SOPT5_UART0RXSRC_MASK = 0xC;
pub const SIM_SOPT5_UART0RXSRC_SHIFT = 2;
pub const SIM_SOPT5_UART1TXSRC_MASK = 0x30;
pub const SIM_SOPT5_UART1TXSRC_SHIFT = 4;
pub const SIM_SOPT5_UART1RXSRC_MASK = 0xC0;
pub const SIM_SOPT5_UART1RXSRC_SHIFT = 6;

// SOPT7 Bit Fields
pub const SIM_SOPT7_ADC0TRGSEL_MASK = 0xF;
pub const SIM_SOPT7_ADC0TRGSEL_SHIFT = 0;
pub const SIM_SOPT7_ADC0PRETRGSEL_MASK = 0x10;
pub const SIM_SOPT7_ADC0PRETRGSEL_SHIFT = 4;
pub const SIM_SOPT7_ADC0ALTTRGEN_MASK = 0x80;
pub const SIM_SOPT7_ADC0ALTTRGEN_SHIFT = 7;
pub const SIM_SOPT7_ADC1TRGSEL_MASK = 0xF00;
pub const SIM_SOPT7_ADC1TRGSEL_SHIFT = 8;
pub const SIM_SOPT7_ADC1PRETRGSEL_MASK = 0x1000;
pub const SIM_SOPT7_ADC1PRETRGSEL_SHIFT = 12;
pub const SIM_SOPT7_ADC1ALTTRGEN_MASK = 0x8000;
pub const SIM_SOPT7_ADC1ALTTRGEN_SHIFT = 15;

// SDID Bit Fields
pub const SIM_SDID_PINID_MASK = 0xF;
pub const SIM_SDID_PINID_SHIFT = 0;
pub const SIM_SDID_FAMID_MASK = 0x70;
pub const SIM_SDID_FAMID_SHIFT = 4;
pub const SIM_SDID_REVID_MASK = 0xF000;
pub const SIM_SDID_REVID_SHIFT = 12;

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
// CLKDIV1 Bit Fields
pub const SIM_CLKDIV1_OUTDIV4_MASK = 0xF0000;
pub const SIM_CLKDIV1_OUTDIV4_SHIFT = 16;
pub const SIM_CLKDIV1_OUTDIV3_MASK = 0xF00000;
pub const SIM_CLKDIV1_OUTDIV3_SHIFT = 20;
pub const SIM_CLKDIV1_OUTDIV2_MASK = 0xF000000;
pub const SIM_CLKDIV1_OUTDIV2_SHIFT = 24;
pub const SIM_CLKDIV1_OUTDIV1_MASK = 0xF0000000;
pub const SIM_CLKDIV1_OUTDIV1_SHIFT = 28;

// CLKDIV2 Bit Fields
pub const SIM_CLKDIV2_USBFRAC_MASK = 0x1;
pub const SIM_CLKDIV2_USBFRAC_SHIFT = 0;
pub const SIM_CLKDIV2_USBDIV_MASK = 0xE;
pub const SIM_CLKDIV2_USBDIV_SHIFT = 1;

// FCFG1 Bit Fields
pub const SIM_FCFG1_FLASHDIS_MASK = 0x1;
pub const SIM_FCFG1_FLASHDIS_SHIFT = 0;
pub const SIM_FCFG1_FLASHDOZE_MASK = 0x2;
pub const SIM_FCFG1_FLASHDOZE_SHIFT = 1;
pub const SIM_FCFG1_DEPART_MASK = 0xF00;
pub const SIM_FCFG1_DEPART_SHIFT = 8;
pub const SIM_FCFG1_EESIZE_MASK = 0xF0000;
pub const SIM_FCFG1_EESIZE_SHIFT = 16;
pub const SIM_FCFG1_PFSIZE_MASK = 0xF000000;
pub const SIM_FCFG1_PFSIZE_SHIFT = 24;
pub const SIM_FCFG1_NVMSIZE_MASK = 0xF0000000;
pub const SIM_FCFG1_NVMSIZE_SHIFT = 28;

// FCFG2 Bit Fields
pub const SIM_FCFG2_MAXADDR1_MASK = 0x7F0000;
pub const SIM_FCFG2_MAXADDR1_SHIFT = 16;
pub const SIM_FCFG2_PFLSH_MASK = 0x800000;
pub const SIM_FCFG2_PFLSH_SHIFT = 23;
pub const SIM_FCFG2_MAXADDR0_MASK = 0x7F000000;
pub const SIM_FCFG2_MAXADDR0_SHIFT = 24;
pub const SIM_FCFG2_SWAPPFLSH_MASK = 0x80000000;
pub const SIM_FCFG2_SWAPPFLSH_SHIFT = 31;

// UIDH Bit Fields
pub const SIM_UIDH_UID_MASK = 0xFFFFFFFF;
pub const SIM_UIDH_UID_SHIFT = 0;
// UIDMH Bit Fields
pub const SIM_UIDMH_UID_MASK = 0xFFFFFFFF;
pub const SIM_UIDMH_UID_SHIFT = 0;
// UIDML Bit Fields
pub const SIM_UIDML_UID_MASK = 0xFFFFFFFF;
pub const SIM_UIDML_UID_SHIFT = 0;
// UIDL Bit Fields
pub const SIM_UIDL_UID_MASK = 0xFFFFFFFF;
pub const SIM_UIDL_UID_SHIFT = 0;

// CR Bit Fields
pub const OSC_CR_SC16P_MASK = 0x1;
pub const OSC_CR_SC16P_SHIFT = 0;
pub const OSC_CR_SC8P_MASK = 0x2;
pub const OSC_CR_SC8P_SHIFT = 1;
pub const OSC_CR_SC4P_MASK = 0x4;
pub const OSC_CR_SC4P_SHIFT = 2;
pub const OSC_CR_SC2P_MASK = 0x8;
pub const OSC_CR_SC2P_SHIFT = 3;
pub const OSC_CR_EREFSTEN_MASK = 0x20;
pub const OSC_CR_EREFSTEN_SHIFT = 5;
pub const OSC_CR_ERCLKEN_MASK = 0x80;
pub const OSC_CR_ERCLKEN_SHIFT = 7;

// C1 Bit Fields
pub const MCG_C1_IREFSTEN_MASK = 0x1;
pub const MCG_C1_IREFSTEN_SHIFT = 0;
pub const MCG_C1_IRCLKEN_MASK = 0x2;
pub const MCG_C1_IRCLKEN_SHIFT = 1;
pub const MCG_C1_IREFS_MASK = 0x4;
pub const MCG_C1_IREFS_SHIFT = 2;
pub const MCG_C1_FRDIV_MASK = 0x38;
pub const MCG_C1_FRDIV_SHIFT = 3;
pub const MCG_C1_CLKS_MASK = 0xC0;
pub const MCG_C1_CLKS_SHIFT = 6;

// C2 Bit Fields
pub const MCG_C2_IRCS_MASK = 0x1;
pub const MCG_C2_IRCS_SHIFT = 0;
pub const MCG_C2_LP_MASK = 0x2;
pub const MCG_C2_LP_SHIFT = 1;
pub const MCG_C2_EREFS0_MASK = 0x4;
pub const MCG_C2_EREFS0_SHIFT = 2;
pub const MCG_C2_HGO0_MASK = 0x8;
pub const MCG_C2_HGO0_SHIFT = 3;
pub const MCG_C2_RANGE0_MASK = 0x30;
pub const MCG_C2_RANGE0_SHIFT = 4;
pub const MCG_C2_LOCRE0_MASK = 0x80;
pub const MCG_C2_LOCRE0_SHIFT = 7;
// C3 Bit Fields
pub const MCG_C3_SCTRIM_MASK = 0xFF;
pub const MCG_C3_SCTRIM_SHIFT = 0;
// C4 Bit Fields
pub const MCG_C4_SCFTRIM_MASK = 0x1;
pub const MCG_C4_SCFTRIM_SHIFT = 0;
pub const MCG_C4_FCTRIM_MASK = 0x1E;
pub const MCG_C4_FCTRIM_SHIFT = 1;
pub const MCG_C4_DRST_DRS_MASK = 0x60;
pub const MCG_C4_DRST_DRS_SHIFT = 5;
pub const MCG_C4_DMX32_MASK = 0x80;
pub const MCG_C4_DMX32_SHIFT = 7;
// C5 Bit Fields
pub const MCG_C5_PRDIV0_MASK = 0x1F;
pub const MCG_C5_PRDIV0_SHIFT = 0;
pub const MCG_C5_PLLSTEN0_MASK = 0x20;
pub const MCG_C5_PLLSTEN0_SHIFT = 5;
pub const MCG_C5_PLLCLKEN0_MASK = 0x40;
pub const MCG_C5_PLLCLKEN0_SHIFT = 6;
// C6 Bit Fields
pub const MCG_C6_VDIV0_MASK = 0x1F;
pub const MCG_C6_VDIV0_SHIFT = 0;
pub const MCG_C6_CME0_MASK = 0x20;
pub const MCG_C6_CME0_SHIFT = 5;
pub const MCG_C6_PLLS_MASK = 0x40;
pub const MCG_C6_PLLS_SHIFT = 6;
pub const MCG_C6_LOLIE0_MASK = 0x80;
pub const MCG_C6_LOLIE0_SHIFT = 7;

// S Bit Fields
pub const MCG_S_IRCST_MASK = 0x1;
pub const MCG_S_IRCST_SHIFT = 0;
pub const MCG_S_OSCINIT0_MASK = 0x2;
pub const MCG_S_OSCINIT0_SHIFT = 1;
pub const MCG_S_CLKST_MASK = 0xC;
pub const MCG_S_CLKST_SHIFT = 2;
pub const MCG_S_IREFST_MASK = 0x10;
pub const MCG_S_IREFST_SHIFT = 4;
pub const MCG_S_PLLST_MASK = 0x20;
pub const MCG_S_PLLST_SHIFT = 5;
pub const MCG_S_LOCK0_MASK = 0x40;
pub const MCG_S_LOCK0_SHIFT = 6;
pub const MCG_S_LOLS0_MASK = 0x80;
pub const MCG_S_LOLS0_SHIFT = 7;

// Addresses
pub const PORTB_PCR16_ADDR = 0x4004A040;
pub const PORTB_PCR17_ADDR = 0x4004A044;

pub const GPIOC_PSOR_ADDR = 0x400FF084;
pub const GPIOC_PCOR_ADDR = 0x400FF088;

pub const GPIOC_PDDR_ADDR = 0x400FF094;
pub const PORTC_PCR_ADDR = 0x4004B000;

pub const UART0_BASE_ADDR = 0x4006A000;

pub const WDOG_UNLOCK_ADDR = 0x4005200E;
pub const WDOG_STCTRLH_ADDR = 0x40052000;

pub const PMC_REGSC_ADDR = 0x4007D002; // 8 bit

pub const SMC_PMPROT_ADDR = 0x4007E000;

pub const SIM_SCGC4_ADDR = 0x40048034;
pub const SIM_SCGC5_ADDR = 0x40048038;
pub const SIM_CLKDIV1_ADDR = 0x40048044;
pub const SIM_CLKDIV2_ADDR = 0x40048048;

pub const SIM_SOPT2_ADDR = 0x40048004;

pub const MCG_C1_ADDR = 0x40064000;
pub const MCG_C2_ADDR = 0x40064001;
pub const MCG_C3_ADDR = 0x40064002;
pub const MCG_C4_ADDR = 0x40064003;
pub const MCG_C5_ADDR = 0x40064004;
pub const MCG_C6_ADDR = 0x40064005;
pub const MCG_S_ADDR = 0x40064006;

pub const OSC_CR_ADDR = 0x40065000;

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

pub fn mcg_c2_range0(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C2_RANGE0_SHIFT, MCG_C2_RANGE0_MASK);
}

pub fn mcg_c1_frdiv(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C1_FRDIV_SHIFT, MCG_C1_FRDIV_MASK);
}

pub fn mcg_c1_clks(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C1_CLKS_SHIFT, MCG_C1_CLKS_MASK);
}

pub fn mcg_s_clkst(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_S_CLKST_SHIFT, MCG_S_CLKST_MASK);
}

pub fn mcg_c3_sctrim(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C3_SCTRIM_SHIFT, MCG_C3_SCTRIM_MASK);
}

pub fn mcg_c4_fctrim(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C4_FCTRIM_SHIFT, MCG_C4_FCTRIM_MASK);
}

pub fn mcg_c4_drst_drs(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C4_DRST_DRS_SHI, MCG_C4_DRST_DRS_MASKFT);
}

pub fn mcg_c5_prdiv0(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C5_PRDIV0_SHIFT, MCG_C5_PRDIV0_MASK);
}

pub fn mcg_c6_vdiv0(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, MCG_C6_VDIV0_SHIFT, MCG_C6_VDIV0_MASK);
}

pub fn sim_clkdiv1_outdiv4(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_CLKDIV1_OUTDIV4_SHIFT, SIM_CLKDIV1_OUTDIV4_MASK);
}
pub fn sim_clkdiv1_outdiv3(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_CLKDIV1_OUTDIV3_SHIFT, SIM_CLKDIV1_OUTDIV3_MASK);
}
pub fn sim_clkdiv1_outdiv2(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_CLKDIV1_OUTDIV2_SHIFT, SIM_CLKDIV1_OUTDIV2_MASK);
}
pub fn sim_clkdiv1_outdiv1(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_CLKDIV1_OUTDIV1_SHIFT, SIM_CLKDIV1_OUTDIV1_MASK);
}

pub fn sim_clkdiv2_usbdiv(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_CLKDIV2_USBDIV_SHIFT, SIM_CLKDIV2_USBDIV_MASK);
}

pub fn sim_fcfg1_depart(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG1_DEPART_SHIFT, SIM_FCFG1_DEPART_MASK);
}
pub fn sim_fcfg1_eesize(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG1_EESIZE_SHIFT, SIM_FCFG1_EESIZE_MASK);
}
pub fn sim_fcfg1_pfsize(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG1_PFSIZE_SHIFT, SIM_FCFG1_PFSIZE_MASK);
}
pub fn sim_fcfg1_nvmsize(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG1_NVMSIZE_SHIFT, SIM_FCFG1_NVMSIZE_MASK);
}

pub fn sim_fcfg2_maxaddr1(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG2_MAXADDR1_SHIFT, SIM_FCFG2_MAXADDR1_MASK);
}
pub fn sim_fcfg2_maxaddr0(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_FCFG2_MAXADDR0_SHIFT, SIM_FCFG2_MAXADDR0_MASK);
}

pub fn sim_uidh_uid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_UIDH_UID_SHIFT, SIM_UIDH_UID_MASK);
}
pub fn sim_uidmh_uid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_UIDMH_UID_SHIFT, SIM_UIDMH_UID_MASK);
}
pub fn sim_uidml_uid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_UIDML_UID_SHIFT, SIM_UIDML_UID_MASK);
}
pub fn sim_uidl_uid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_UIDL_UID_SHIFT, SIM_UIDL_UID_MASK);
}

pub fn sim_sopt1_ramsize(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT1_RAMSIZE_SHIFT, SIM_SOPT1_RAMSIZE_MASK);
}
pub fn sim_sopt1_osc32ksel(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT1_OSC32KSEL_SHIFT, SIM_SOPT1_OSC32KSEL_MASK);
}

pub fn sim_sopt2_clkoutsel(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT2_CLKOUTSEL_SHIFT, SIM_SOPT2_CLKOUTSEL_MASK);
}
pub fn sim_sopt2_fbsl(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT2_FBSL_SHIFT, SIM_SOPT2_FBSL_MASK);
}

pub fn sim_sopt5_uart0txsrc(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT5_UART0TXSRC_SHIFT, SIM_SOPT5_UART0TXSRC_MASK);
}
pub fn sim_sopt5_uart0rxsrc(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT5_UART0RXSRC_SHIFT, SIM_SOPT5_UART0RXSRC_MASK);
}
pub fn sim_sopt5_uart1txsrc(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT5_UART1TXSRC_SHIFT, SIM_SOPT5_UART1TXSRC_MASK);
}
pub fn sim_sopt5_uart1rxsrc(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT5_UART1RXSRC_SHIFT, SIM_SOPT5_UART1RXSRC_MASK);
}

pub fn sim_sopt7_adc0trgsel(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT7_ADC0TRGSEL_SHIFT, SIM_SOPT7_ADC0TRGSEL_MASK);
}
pub fn sim_sopt7_adc1trgsel(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT7_ADC1TRGSEL_SHIFT, SIM_SOPT7_ADC1TRGSEL_MASK);
}

pub fn sim_sdid_pinid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SDID_PINID_SHIFT, SIM_SDID_PINID_MASK);
}
pub fn sim_sdid_famid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SDID_FAMID_SHIFT, SIM_SDID_FAMID_MASK);
}
pub fn sim_sdid_revid(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SDID_REVID_SHIFT, SIM_SDID_REVID_MASK);
}

pub fn sim_sopt4_ftm1ch0src(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT4_FTM1CH0SRC_SHIFT, SIM_SOPT4_FTM1CH0SRC_MASK);
}
pub fn sim_sopt4_ftm2ch0src(comptime x: comptime_int) comptime_int {
    return left_shift_and_mask(x, SIM_SOPT4_FTM2CH0SRC_SHIFT, SIM_SOPT4_FTM2CH0SRC_MASK);
}

fn left_shift_and_mask(comptime x: comptime_int, comptime shift: u5, comptime mask: u32) comptime_int {
    return (x << shift) & mask;
}

pub inline fn nop() void {
    asm volatile ("nop");
}
