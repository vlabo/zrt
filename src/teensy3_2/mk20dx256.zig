pub const PORT_PCR_MUX_SHIFT = 8;
pub const PORT_PCR_MUX_MASK = 0x700;

pub const UART_BDH_SBR_SHIFT = 0;
pub const UART_BDH_SBR_MASK = 0x1F;

pub const UART_BDL_SBR_MASK = 0xFF;
pub const UART_BDL_SBR_SHIFT = 0;

pub const UART_C4_BRFA_MASK = 0x1F;
pub const UART_C4_BRFA_SHIFT = 0;

pub const UART_S1_TDRE_MASK = 0x80;

pub const SIM_SCGC4_UART0_MASK = 0x400;
pub const UART_C2_TE_MASK = 0x8;

pub const PORT_PCR_SRE_MASK = 0x4;
pub const PORT_PCR_DSE_MASK = 0x40;

// Addresses
pub const PORTB_PCR16_ADDR = 0x4004A040;
pub const PORTB_PCR17_ADDR = 0x4004A044;

pub const SIM_SCGC4_ADDR = 0x40048034;

pub const GPIOC_PSOR_ADDR = 0x400FF084;
pub const GPIOC_PCOR_ADDR = 0x400FF088;

pub const GPIOC_PDDR_ADDR = 0x400FF094;
pub const PORTC_PCR5_ADDR = 0x4004B014;

pub const UART0_BASE_ADDR = 0x4006A000;

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
