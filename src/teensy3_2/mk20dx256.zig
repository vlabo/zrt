pub const PORT_PCR_MUX_SHIFT = 8;
pub const PORT_PCR_MUX_MASK = 0x700;

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

// BDH Bit Fields
pub const UART_BDH_SBR_MASK = 0x1F;
pub const UART_BDH_SBR_SHIFT = 0;
pub const UART_BDH_RXEDGIE_MASK = 0x40;
pub const UART_BDH_RXEDGIE_SHIFT = 6;
pub const UART_BDH_LBKDIE_MASK = 0x80;
pub const UART_BDH_LBKDIE_SHIFT = 7;
// BDL Bit Fields
pub const UART_BDL_SBR_MASK = 0xFF;
pub const UART_BDL_SBR_SHIFT = 0;
// C1 Bit Fields
pub const UART_C1_PT_MASK = 0x1;
pub const UART_C1_PT_SHIFT = 0;
pub const UART_C1_PE_MASK = 0x2;
pub const UART_C1_PE_SHIFT = 1;
pub const UART_C1_ILT_MASK = 0x4;
pub const UART_C1_ILT_SHIFT = 2;
pub const UART_C1_WAKE_MASK = 0x8;
pub const UART_C1_WAKE_SHIFT = 3;
pub const UART_C1_M_MASK = 0x10;
pub const UART_C1_M_SHIFT = 4;
pub const UART_C1_RSRC_MASK = 0x20;
pub const UART_C1_RSRC_SHIFT = 5;
pub const UART_C1_UARTSWAI_MASK = 0x40;
pub const UART_C1_UARTSWAI_SHIFT = 6;
pub const UART_C1_LOOPS_MASK = 0x80;
pub const UART_C1_LOOPS_SHIFT = 7;
// C2 Bit Fields
pub const UART_C2_SBK_MASK = 0x1;
pub const UART_C2_SBK_SHIFT = 0;
pub const UART_C2_RWU_MASK = 0x2;
pub const UART_C2_RWU_SHIFT = 1;
pub const UART_C2_RE_MASK = 0x4;
pub const UART_C2_RE_SHIFT = 2;
pub const UART_C2_TE_MASK = 0x8;
pub const UART_C2_TE_SHIFT = 3;
pub const UART_C2_ILIE_MASK = 0x10;
pub const UART_C2_ILIE_SHIFT = 4;
pub const UART_C2_RIE_MASK = 0x20;
pub const UART_C2_RIE_SHIFT = 5;
pub const UART_C2_TCIE_MASK = 0x40;
pub const UART_C2_TCIE_SHIFT = 6;
pub const UART_C2_TIE_MASK = 0x80;
pub const UART_C2_TIE_SHIFT = 7;
// S1 Bit Fields
pub const UART_S1_PF_MASK = 0x1;
pub const UART_S1_PF_SHIFT = 0;
pub const UART_S1_FE_MASK = 0x2;
pub const UART_S1_FE_SHIFT = 1;
pub const UART_S1_NF_MASK = 0x4;
pub const UART_S1_NF_SHIFT = 2;
pub const UART_S1_OR_MASK = 0x8;
pub const UART_S1_OR_SHIFT = 3;
pub const UART_S1_IDLE_MASK = 0x10;
pub const UART_S1_IDLE_SHIFT = 4;
pub const UART_S1_RDRF_MASK = 0x20;
pub const UART_S1_RDRF_SHIFT = 5;
pub const UART_S1_TC_MASK = 0x40;
pub const UART_S1_TC_SHIFT = 6;
pub const UART_S1_TDRE_MASK = 0x80;
pub const UART_S1_TDRE_SHIFT = 7;
// S2 Bit Fields
pub const UART_S2_RAF_MASK = 0x1;
pub const UART_S2_RAF_SHIFT = 0;
pub const UART_S2_LBKDE_MASK = 0x2;
pub const UART_S2_LBKDE_SHIFT = 1;
pub const UART_S2_BRK13_MASK = 0x4;
pub const UART_S2_BRK13_SHIFT = 2;
pub const UART_S2_RWUID_MASK = 0x8;
pub const UART_S2_RWUID_SHIFT = 3;
pub const UART_S2_RXINV_MASK = 0x10;
pub const UART_S2_RXINV_SHIFT = 4;
pub const UART_S2_MSBF_MASK = 0x20;
pub const UART_S2_MSBF_SHIFT = 5;
pub const UART_S2_RXEDGIF_MASK = 0x40;
pub const UART_S2_RXEDGIF_SHIFT = 6;
pub const UART_S2_LBKDIF_MASK = 0x80;
pub const UART_S2_LBKDIF_SHIFT = 7;
// C3 Bit Fields
pub const UART_C3_PEIE_MASK = 0x1;
pub const UART_C3_PEIE_SHIFT = 0;
pub const UART_C3_FEIE_MASK = 0x2;
pub const UART_C3_FEIE_SHIFT = 1;
pub const UART_C3_NEIE_MASK = 0x4;
pub const UART_C3_NEIE_SHIFT = 2;
pub const UART_C3_ORIE_MASK = 0x8;
pub const UART_C3_ORIE_SHIFT = 3;
pub const UART_C3_TXINV_MASK = 0x10;
pub const UART_C3_TXINV_SHIFT = 4;
pub const UART_C3_TXDIR_MASK = 0x20;
pub const UART_C3_TXDIR_SHIFT = 5;
pub const UART_C3_T8_MASK = 0x40;
pub const UART_C3_T8_SHIFT = 6;
pub const UART_C3_R8_MASK = 0x80;
pub const UART_C3_R8_SHIFT = 7;
// D Bit Fields
pub const UART_D_RT_MASK = 0xFF;
pub const UART_D_RT_SHIFT = 0;
// MA1 Bit Fields
pub const UART_MA1_MA_MASK = 0xFF;
pub const UART_MA1_MA_SHIFT = 0;
// MA2 Bit Fields
pub const UART_MA2_MA_MASK = 0xFF;
pub const UART_MA2_MA_SHIFT = 0;
// C4 Bit Fields
pub const UART_C4_BRFA_MASK = 0x1F;
pub const UART_C4_BRFA_SHIFT = 0;
pub const UART_C4_M10_MASK = 0x20;
pub const UART_C4_M10_SHIFT = 5;
pub const UART_C4_MAEN2_MASK = 0x40;
pub const UART_C4_MAEN2_SHIFT = 6;
pub const UART_C4_MAEN1_MASK = 0x80;
pub const UART_C4_MAEN1_SHIFT = 7;
// C5 Bit Fields
pub const UART_C5_RDMAS_MASK = 0x20;
pub const UART_C5_RDMAS_SHIFT = 5;
pub const UART_C5_TDMAS_MASK = 0x80;
pub const UART_C5_TDMAS_SHIFT = 7;
// ED Bit Fields
pub const UART_ED_PARITYE_MASK = 0x40;
pub const UART_ED_PARITYE_SHIFT = 6;
pub const UART_ED_NOISY_MASK = 0x80;
pub const UART_ED_NOISY_SHIFT = 7;
// MODEM Bit Fields
pub const UART_MODEM_TXCTSE_MASK = 0x1;
pub const UART_MODEM_TXCTSE_SHIFT = 0;
pub const UART_MODEM_TXRTSE_MASK = 0x2;
pub const UART_MODEM_TXRTSE_SHIFT = 1;
pub const UART_MODEM_TXRTSPOL_MASK = 0x4;
pub const UART_MODEM_TXRTSPOL_SHIFT = 2;
pub const UART_MODEM_RXRTSE_MASK = 0x8;
pub const UART_MODEM_RXRTSE_SHIFT = 3;
// IR Bit Fields
pub const UART_IR_TNP_MASK = 0x3;
pub const UART_IR_TNP_SHIFT = 0;

pub const UART_IR_IREN_MASK = 0x4;
pub const UART_IR_IREN_SHIFT = 2;
// PFIFO Bit Fields
pub const UART_PFIFO_RXFIFOSIZE_MASK = 0x7;
pub const UART_PFIFO_RXFIFOSIZE_SHIFT = 0;
pub const UART_PFIFO_RXFE_MASK = 0x8;
pub const UART_PFIFO_RXFE_SHIFT = 3;
pub const UART_PFIFO_TXFIFOSIZE_MASK = 0x70;
pub const UART_PFIFO_TXFIFOSIZE_SHIFT = 4;
pub const UART_PFIFO_TXFE_MASK = 0x80;
pub const UART_PFIFO_TXFE_SHIFT = 7;
// CFIFO Bit Fields
pub const UART_CFIFO_RXUFE_MASK = 0x1;
pub const UART_CFIFO_RXUFE_SHIFT = 0;
pub const UART_CFIFO_TXOFE_MASK = 0x2;
pub const UART_CFIFO_TXOFE_SHIFT = 1;
pub const UART_CFIFO_RXFLUSH_MASK = 0x40;
pub const UART_CFIFO_RXFLUSH_SHIFT = 6;
pub const UART_CFIFO_TXFLUSH_MASK = 0x80;
pub const UART_CFIFO_TXFLUSH_SHIFT = 7;
// SFIFO Bit Fields
pub const UART_SFIFO_RXUF_MASK = 0x1;
pub const UART_SFIFO_RXUF_SHIFT = 0;
pub const UART_SFIFO_TXOF_MASK = 0x2;
pub const UART_SFIFO_TXOF_SHIFT = 1;
pub const UART_SFIFO_RXEMPT_MASK = 0x40;
pub const UART_SFIFO_RXEMPT_SHIFT = 6;
pub const UART_SFIFO_TXEMPT_MASK = 0x80;
pub const UART_SFIFO_TXEMPT_SHIFT = 7;
// TWFIFO Bit Fields
pub const UART_TWFIFO_TXWATER_MASK = 0xFF;
pub const UART_TWFIFO_TXWATER_SHIFT = 0;
// TCFIFO Bit Fields
pub const UART_TCFIFO_TXCOUNT_MASK = 0xFF;
pub const UART_TCFIFO_TXCOUNT_SHIFT = 0;
// RWFIFO Bit Fields
pub const UART_RWFIFO_RXWATER_MASK = 0xFF;
pub const UART_RWFIFO_RXWATER_SHIFT = 0;
// RCFIFO Bit Fields
pub const UART_RCFIFO_RXCOUNT_MASK = 0xFF;
pub const UART_RCFIFO_RXCOUNT_SHIFT = 0;
// C7816 Bit Fields
pub const UART_C7816_ISO_7816E_MASK = 0x1;
pub const UART_C7816_ISO_7816E_SHIFT = 0;
pub const UART_C7816_TTYPE_MASK = 0x2;
pub const UART_C7816_TTYPE_SHIFT = 1;
pub const UART_C7816_INIT_MASK = 0x4;
pub const UART_C7816_INIT_SHIFT = 2;
pub const UART_C7816_ANACK_MASK = 0x8;
pub const UART_C7816_ANACK_SHIFT = 3;
pub const UART_C7816_ONACK_MASK = 0x10;
pub const UART_C7816_ONACK_SHIFT = 4;
// IE7816 Bit Fields
pub const UART_IE7816_RXTE_MASK = 0x1;
pub const UART_IE7816_RXTE_SHIFT = 0;
pub const UART_IE7816_TXTE_MASK = 0x2;
pub const UART_IE7816_TXTE_SHIFT = 1;
pub const UART_IE7816_GTVE_MASK = 0x4;
pub const UART_IE7816_GTVE_SHIFT = 2;
pub const UART_IE7816_INITDE_MASK = 0x10;
pub const UART_IE7816_INITDE_SHIFT = 4;
pub const UART_IE7816_BWTE_MASK = 0x20;
pub const UART_IE7816_BWTE_SHIFT = 5;
pub const UART_IE7816_CWTE_MASK = 0x40;
pub const UART_IE7816_CWTE_SHIFT = 6;
pub const UART_IE7816_WTE_MASK = 0x80;
pub const UART_IE7816_WTE_SHIFT = 7;
// IS7816 Bit Fields
pub const UART_IS7816_RXT_MASK = 0x1;
pub const UART_IS7816_RXT_SHIFT = 0;
pub const UART_IS7816_TXT_MASK = 0x2;
pub const UART_IS7816_TXT_SHIFT = 1;
pub const UART_IS7816_GTV_MASK = 0x4;
pub const UART_IS7816_GTV_SHIFT = 2;
pub const UART_IS7816_INITD_MASK = 0x10;
pub const UART_IS7816_INITD_SHIFT = 4;
pub const UART_IS7816_BWT_MASK = 0x20;
pub const UART_IS7816_BWT_SHIFT = 5;
pub const UART_IS7816_CWT_MASK = 0x40;
pub const UART_IS7816_CWT_SHIFT = 6;
pub const UART_IS7816_WT_MASK = 0x80;
pub const UART_IS7816_WT_SHIFT = 7;
// WP7816_T_TYPE0 Bit Fields
pub const UART_WP7816_T_TYPE0_WI_MASK = 0xFF;
pub const UART_WP7816_T_TYPE0_WI_SHIFT = 0;
// WP7816_T_TYPE1 Bit Fields
pub const UART_WP7816_T_TYPE1_BWI_MASK = 0xF;
pub const UART_WP7816_T_TYPE1_BWI_SHIFT = 0;
pub const UART_WP7816_T_TYPE1_CWI_MASK = 0xF0;
pub const UART_WP7816_T_TYPE1_CWI_SHIFT = 4;
// WN7816 Bit Fields
pub const UART_WN7816_GTN_MASK = 0xFF;
pub const UART_WN7816_GTN_SHIFT = 0;
// WF7816 Bit Fields
pub const UART_WF7816_GTFD_MASK = 0xFF;
pub const UART_WF7816_GTFD_SHIFT = 0;
// ET7816 Bit Fields
pub const UART_ET7816_RXTHRESHOLD_MASK = 0xF;
pub const UART_ET7816_RXTHRESHOLD_SHIFT = 0;
pub const UART_ET7816_TXTHRESHOLD_MASK = 0xF0;
pub const UART_ET7816_TXTHRESHOLD_SHIFT = 4;
// TL7816 Bit Fields
pub const UART_TL7816_TLEN_MASK = 0xFF;
pub const UART_TL7816_TLEN_SHIFT = 0;

//define UART_TWFIFO_TXWATER(x)                   (((uint8_t)(((uint8_t)(x))<<UART_TWFIFO_TXWATER_SHIFT))&UART_TWFIFO_TXWATER_MASK)
//define UART_IR_TNP(x)                           (((uint8_t)(((uint8_t)(x))<<UART_IR_TNP_SHIFT))&UART_IR_TNP_MASK)
//define UART_D_RT(x)                             (((uint8_t)(((uint8_t)(x))<<UART_D_RT_SHIFT))&UART_D_RT_MASK)
//define UART_PFIFO_RXFIFOSIZE(x)                 (((uint8_t)(((uint8_t)(x))<<UART_PFIFO_RXFIFOSIZE_SHIFT))&UART_PFIFO_RXFIFOSIZE_MASK)
//define UART_MA1_MA(x)                           (((uint8_t)(((uint8_t)(x))<<UART_MA1_MA_SHIFT))&UART_MA1_MA_MASK)
//define UART_MA2_MA(x)                           (((uint8_t)(((uint8_t)(x))<<UART_MA2_MA_SHIFT))&UART_MA2_MA_MASK)
//define UART_PFIFO_TXFIFOSIZE(x)                 (((uint8_t)(((uint8_t)(x))<<UART_PFIFO_TXFIFOSIZE_SHIFT))&UART_PFIFO_TXFIFOSIZE_MASK)
//define UART_TCFIFO_TXCOUNT(x)                   (((uint8_t)(((uint8_t)(x))<<UART_TCFIFO_TXCOUNT_SHIFT))&UART_TCFIFO_TXCOUNT_MASK)
//define UART_RWFIFO_RXWATER(x)                   (((uint8_t)(((uint8_t)(x))<<UART_RWFIFO_RXWATER_SHIFT))&UART_RWFIFO_RXWATER_MASK)
//define UART_RCFIFO_RXCOUNT(x)                   (((uint8_t)(((uint8_t)(x))<<UART_RCFIFO_RXCOUNT_SHIFT))&UART_RCFIFO_RXCOUNT_MASK)
//define UART_C4_BRFA(x)                          (((uint8_t)(((uint8_t)(x))<<UART_C4_BRFA_SHIFT))&UART_C4_BRFA_MASK)
//define UART_BDL_SBR(x)                          (((uint8_t)(((uint8_t)(x))<<UART_BDL_SBR_SHIFT))&UART_BDL_SBR_MASK)
//define UART_BDH_SBR(x)                          (((uint8_t)(((uint8_t)(x))<<UART_BDH_SBR_SHIFT))&UART_BDH_SBR_MASK)

//define UART_WP7816_T_TYPE0_WI(x)                (((uint8_t)(((uint8_t)(x))<<UART_WP7816_T_TYPE0_WI_SHIFT))&UART_WP7816_T_TYPE0_WI_MASK)
//define UART_WP7816_T_TYPE1_BWI(x)               (((uint8_t)(((uint8_t)(x))<<UART_WP7816_T_TYPE1_BWI_SHIFT))&UART_WP7816_T_TYPE1_BWI_MASK)
//define UART_WP7816_T_TYPE1_CWI(x)               (((uint8_t)(((uint8_t)(x))<<UART_WP7816_T_TYPE1_CWI_SHIFT))&UART_WP7816_T_TYPE1_CWI_MASK)
//define UART_WN7816_GTN(x)                       (((uint8_t)(((uint8_t)(x))<<UART_WN7816_GTN_SHIFT))&UART_WN7816_GTN_MASK)
//define UART_WF7816_GTFD(x)                      (((uint8_t)(((uint8_t)(x))<<UART_WF7816_GTFD_SHIFT))&UART_WF7816_GTFD_MASK)
//define UART_ET7816_RXTHRESHOLD(x)               (((uint8_t)(((uint8_t)(x))<<UART_ET7816_RXTHRESHOLD_SHIFT))&UART_ET7816_RXTHRESHOLD_MASK)
//define UART_ET7816_TXTHRESHOLD(x)               (((uint8_t)(((uint8_t)(x))<<UART_ET7816_TXTHRESHOLD_SHIFT))&UART_ET7816_TXTHRESHOLD_MASK)
//define UART_TL7816_TLEN(x)                      (((uint8_t)(((uint8_t)(x))<<UART_TL7816_TLEN_SHIFT))&UART_TL7816_TLEN_MASK)

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

pub const Port = struct {
    controlRegister: [32]u32, // PCR 0-31
    globalPinControlLow: u32, // GPCLR
    globalPinControlHigh: u32, // GPCHR
    reserved: [24]u8,
    interuptStatusFlag: u32, // ISFR
};

pub const Gpio = struct {
    dataOutput: u32, // PDOR
    setOutput: u32, // PSOR
    clearOutput: u32, // PCOR
    toggleOutput: u32, // PTOR
    dataInput: u32, // PDIR
    dataDirection: u32, // PDDR
};

const UartMemMap = struct {
    BDH: u8, // < UART Baud Rate Registers:High, offset: 0x0
    BDL: u8, // < UART Baud Rate Registers: Low, offset: 0x1
    C1: u8, // < UART Control Register 1, offset: 0x2
    C2: u8, // < UART Control Register 2, offset: 0x3
    S1: u8, // < UART Status Register 1, offset: 0x4
    S2: u8, // < UART Status Register 2, offset: 0x5
    C3: u8, // < UART Control Register 3, offset: 0x6
    D: u8, // < UART Data Register, offset: 0x7
    MA1: u8, // < UART Match Address Registers 1, offset: 0x8
    MA2: u8, // < UART Match Address Registers 2, offset: 0x9
    C4: u8, // < UART Control Register 4, offset: 0xA
    C5: u8, // < UART Control Register 5, offset: 0xB
    ED: u8, // < UART Extended Data Register, offset: 0xC
    MODEM: u8, // < UART Modem Register, offset: 0xD
    IR: u8, // < UART Infrared Register, offset: 0xE
    RESERVED_0: u8,
    PFIFO: u8, // < UART FIFO Parameters, offset: 0x10
    CFIFO: u8, // < UART FIFO Control Register, offset: 0x11
    SFIFO: u8, // < UART FIFO Status Register, offset: 0x12
    TWFIFO: u8, // < UART FIFO Transmit Watermark, offset: 0x13
    TCFIFO: u8, // < UART FIFO Transmit Count, offset: 0x14
    RWFIFO: u8, // < UART FIFO Receive Watermark, offset: 0x15
    RCFIFO: u8, // < UART FIFO Receive Count, offset: 0x16
    RESERVED_1: u8,
    C7816: u8, // < UART 7816 Control Register, offset: 0x18
    IE7816: u8, // < UART 7816 Interrupt Enable Register, offset: 0x19
    IS7816: u8, // < UART 7816 Interrupt Status Register, offset: 0x1A
    WP7816_type: u8,
    WN7816: u8, // < UART 7816 Wait N Register, offset: 0x1C
    WF7816: u8, // < UART 7816 Wait FD Register, offset: 0x1D
    ET7816: u8, // < UART 7816 Error Threshold Register, offset: 0x1E
    TL7816: u8, // < UART 7816 Transmit Length Register, offset: 0x1F
};

pub const SystemStruct = struct {
    Options1 : *volatile u32 = @intToPtr(*volatile u32, 0x40047000), // SIM_SOPT1
    Options1ConfigurationRegister : *volatile u32 = @intToPtr(*volatile u32, 0x40047004), // SIM_SOPT1CFG
    Options2 : *volatile u32 = @intToPtr(*volatile u32, 0x40048004), // SIM_SOPT2
    Options4 : *volatile u32 = @intToPtr(*volatile u32, 0x4004800C), // SIM_SOPT4
    Options5 : *volatile u32 = @intToPtr(*volatile u32, 0x40048010), // SIM_SOPT5
    Options7 : *volatile u32 = @intToPtr(*volatile u32, 0x40048018), // SIM_SOPT7
    DeviceIdentification : *volatile u32 = @intToPtr(*volatile u32, 0x40048024), // SIM_SDID
    ClockGating1 : *volatile u32 = @intToPtr(*volatile u32, 0x40048028), // SIM_SCGC1
    ClockGating2 : *volatile u32 = @intToPtr(*volatile u32, 0x4004802C), // SIM_SCGC2
    ClockGating3 : *volatile u32 = @intToPtr(*volatile u32, 0x40048030), // SIM_SCGC3
    ClockGating4 : *volatile u32 = @intToPtr(*volatile u32, 0x40048034), // SIM_SCGC4
    ClockGating5 : *volatile u32 = @intToPtr(*volatile u32, 0x40048038), // SIM_SCGC5
    ClockGating6 : *volatile u32 = @intToPtr(*volatile u32, 0x4004803C), // SIM_SCGC6
    ClockGating7 : *volatile u32 = @intToPtr(*volatile u32, 0x40048040), // SIM_SCGC7
    ClockDevider1 : *volatile u32 = @intToPtr(*volatile u32, 0x40048044), // SIM_CLKDIV1
    ClockDevider2 : *volatile u32 = @intToPtr(*volatile u32, 0x40048048), // SIM_CLKDIV2
    FlashConfiguration1 : *volatile u32 = @intToPtr(*volatile u32, 0x4004804C), // SIM_FCFG1
    FlashConfiguration2 : *volatile u32 = @intToPtr(*volatile u32, 0x40048050), // SIM_FCFG2
    UniqueIdentificationHigh : *volatile u32 = @intToPtr(*volatile u32, 0x40048054), // SIM_UIDH
    UniqueIdentificationMidHigh : *volatile u32 = @intToPtr(*volatile u32, 0x40048058), // SIM_UIDMH
    UniqueIdentificationMidLow : *volatile u32 = @intToPtr(*volatile u32, 0x4004805C), // SIM_UIDML
    UniqueIdentificationLow : *volatile u32 = @intToPtr(*volatile u32, 0x40048060), // SIM_UIDL
};

const MultiPurposeClockGenerator = struct {
    control1: u8, // MCG_C1
    control2: u8, // MCG_C2
    control3: u8, // MCG_C3
    control4: u8, // MCG_C4
    control5: u8, // MCG_C5
    control6: u8, // MCG_C6
    status: u8, // MCG_S
    reserved0: u8,
    statusAndControl: u8, // MCG_SC
    reserved1: u8,
    autoTrimCompareValueHigh: u8, // MCG_ATCVH
    autoTrimCompareValueLow: u8, // MCG_ATCVL
    control7: u8, // MCG_C7
    control8: u8, // MCG_C8
};

const PowerStruct = struct {
    modeProtection: u8, // SMC_PMPROT
    modeControl: u8, // SMC_PMCTRL
    vllsControl: u8, // SMC_VLLSCTRL
    modeStatus: u8, // SMC_PMSTAT
};

const WatchdogStruct = struct {
    statusAndControlHigh: u16, // WDOG_STCTRLH
    statusAndControlLow: u16, // WDOG_STCTRLL
    timeoutValueHigh: u16, // WDOG_TOVALH
    timeoutValueLow: u16, // WDOG_TOVALL
    windowRegisterHigh: u16, // WDOG_WINH
    windowRegisterLow: u16, // WDOG_WINL
    refresh: u16, // WDOG_REFRESH
    unlock: u16, // WDOG_UNLOCK
    timerOutputHigh: u16, // WDOG_TMROUTH
    timerOutputLow: u16, // WDOG_TMROUTL
    resetCount: u16, // WDOG_RSTCNT
    prescaler: u16, // WDOG_PRESC
};

pub var PortA align(32) = @intToPtr(*volatile Port, 0x40049000);
pub var PortB align(32) = @intToPtr(*volatile Port, 0x4004A000);
pub var PortC align(32) = @intToPtr(*volatile Port, 0x4004B000);
pub var PortD align(32) = @intToPtr(*volatile Port, 0x4004C000);
pub var PortE align(32) = @intToPtr(*volatile Port, 0x4004D000);

pub var GpioA align(32) = @intToPtr(*volatile Gpio, 0x400FF000);
pub var GpioB align(32) = @intToPtr(*volatile Gpio, 0x400FF040);
pub var GpioC align(32) = @intToPtr(*volatile Gpio, 0x400FF080);
pub var GpioD align(32) = @intToPtr(*volatile Gpio, 0x400FF0C0);
pub var GpioE align(32) = @intToPtr(*volatile Gpio, 0x400FF100);

pub var System = SystemStruct{};
pub var Uart0 = @intToPtr(*volatile UartMemMap, 0x4006A000);
pub var Uart1 = @intToPtr(*volatile UartMemMap, 0x4006B000);
pub var Uart2 = @intToPtr(*volatile UartMemMap, 0x4006C000);
pub var OscillatorControl = @intToPtr(*volatile u8, 0x40065000);
pub var ClockGenerator = @intToPtr(*volatile MultiPurposeClockGenerator, 0x40064000);
pub var RegolatorStatusAndControl = @intToPtr(*volatile u8, 0x4007D002); // PMC_REGSC

pub var Power = @intToPtr(*volatile PowerStruct, 0x4007E000);

pub var Watchdog = @intToPtr(*volatile WatchdogStruct, 0x40052000);

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

test "PCR" {
    const expectEqual = @import("std").testing.expectEqual;
    var port align(32) = @intToPtr(*volatile Port, 0x40049000);
    expectEqual(@as(usize, 0x40049000), @ptrToInt(&port.controlRegister[0]));
    expectEqual(@as(usize, 0x40049004), @ptrToInt(&port.controlRegister[1]));
    expectEqual(@as(usize, 0x40049008), @ptrToInt(&port.controlRegister[2]));
    expectEqual(@as(usize, 0x4004900C), @ptrToInt(&port.controlRegister[3]));
    expectEqual(@as(usize, 0x40049010), @ptrToInt(&port.controlRegister[4]));
    expectEqual(@as(usize, 0x40049014), @ptrToInt(&port.controlRegister[5]));
    expectEqual(@as(usize, 0x40049018), @ptrToInt(&port.controlRegister[6]));
    expectEqual(@as(usize, 0x4004901C), @ptrToInt(&port.controlRegister[7]));
    expectEqual(@as(usize, 0x40049020), @ptrToInt(&port.controlRegister[8]));
    expectEqual(@as(usize, 0x40049024), @ptrToInt(&port.controlRegister[9]));
    expectEqual(@as(usize, 0x40049028), @ptrToInt(&port.controlRegister[10]));
    expectEqual(@as(usize, 0x4004902C), @ptrToInt(&port.controlRegister[11]));
    expectEqual(@as(usize, 0x40049030), @ptrToInt(&port.controlRegister[12]));
    expectEqual(@as(usize, 0x40049034), @ptrToInt(&port.controlRegister[13]));
    expectEqual(@as(usize, 0x40049038), @ptrToInt(&port.controlRegister[14]));
    expectEqual(@as(usize, 0x4004903C), @ptrToInt(&port.controlRegister[15]));
    expectEqual(@as(usize, 0x40049040), @ptrToInt(&port.controlRegister[16]));
    expectEqual(@as(usize, 0x40049044), @ptrToInt(&port.controlRegister[17]));
    expectEqual(@as(usize, 0x40049048), @ptrToInt(&port.controlRegister[18]));
    expectEqual(@as(usize, 0x4004904C), @ptrToInt(&port.controlRegister[19]));
    expectEqual(@as(usize, 0x40049050), @ptrToInt(&port.controlRegister[20]));
    expectEqual(@as(usize, 0x40049054), @ptrToInt(&port.controlRegister[21]));
    expectEqual(@as(usize, 0x40049058), @ptrToInt(&port.controlRegister[22]));
    expectEqual(@as(usize, 0x4004905C), @ptrToInt(&port.controlRegister[23]));
    expectEqual(@as(usize, 0x40049060), @ptrToInt(&port.controlRegister[24]));
    expectEqual(@as(usize, 0x40049064), @ptrToInt(&port.controlRegister[25]));
    expectEqual(@as(usize, 0x40049068), @ptrToInt(&port.controlRegister[26]));
    expectEqual(@as(usize, 0x4004906C), @ptrToInt(&port.controlRegister[27]));
    expectEqual(@as(usize, 0x40049070), @ptrToInt(&port.controlRegister[28]));
    expectEqual(@as(usize, 0x40049074), @ptrToInt(&port.controlRegister[29]));
    expectEqual(@as(usize, 0x40049078), @ptrToInt(&port.controlRegister[30]));
    expectEqual(@as(usize, 0x4004907C), @ptrToInt(&port.controlRegister[31]));
    expectEqual(@as(usize, 0x40049080), @ptrToInt(&port.gpclr));
    expectEqual(@as(usize, 0x40049084), @ptrToInt(&port.gpchr));
    expectEqual(@as(usize, 0x400490A0), @ptrToInt(&port.isfr));
}

test "Gpio" {
    const expectEqual = @import("std").testing.expectEqual;
    var gpio align(32) = @intToPtr(*volatile Gpio, 0x400FF000);

    expectEqual(@as(usize, 0x400FF000), @ptrToInt(&gpio.dataOutput));
    expectEqual(@as(usize, 0x400FF004), @ptrToInt(&gpio.setOutput));
    expectEqual(@as(usize, 0x400FF008), @ptrToInt(&gpio.clearOutput));
    expectEqual(@as(usize, 0x400FF00C), @ptrToInt(&gpio.toggleOutput));
    expectEqual(@as(usize, 0x400FF010), @ptrToInt(&gpio.dataInput));
    expectEqual(@as(usize, 0x400FF014), @ptrToInt(&gpio.dataDirection));
}