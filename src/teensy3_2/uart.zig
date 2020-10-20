const cpu = @import("mk20dx256.zig");

const UART_MemMap = struct {
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
    RESERVED_0: [1]u8,
    PFIFO: u8, // < UART FIFO Parameters, offset: 0x10
    CFIFO: u8, // < UART FIFO Control Register, offset: 0x11
    SFIFO: u8, // < UART FIFO Status Register, offset: 0x12
    TWFIFO: u8, // < UART FIFO Transmit Watermark, offset: 0x13
    TCFIFO: u8, // < UART FIFO Transmit Count, offset: 0x14
    RWFIFO: u8, // < UART FIFO Receive Watermark, offset: 0x15
    RCFIFO: u8, // < UART FIFO Receive Count, offset: 0x16
    RESERVED_1: [1]u8,
    C7816: u8, // < UART 7816 Control Register, offset: 0x18
    IE7816: u8, // < UART 7816 Interrupt Enable Register, offset: 0x19
    IS7816: u8, // < UART 7816 Interrupt Status Register, offset: 0x1A
    WP7816_type: u8,
    // union {                                          /* offset: 0x1B */
    //   uint8_t WP7816_T_TYPE0;                          /**< UART 7816 Wait Parameter Register, offset: 0x1B */
    //   uint8_t WP7816_T_TYPE1;                          /**< UART 7816 Wait Parameter Register, offset: 0x1B */
    // };
    WN7816: u8, // < UART 7816 Wait N Register, offset: 0x1C
    WF7816: u8, // < UART 7816 Wait FD Register, offset: 0x1D
    ET7816: u8, // < UART 7816 Error Threshold Register, offset: 0x1E
    TL7816: u8, // < UART 7816 Transmit Length Register, offset: 0x1F
};

var PIN0_PORT_PCR align(32) = @intToPtr(*volatile u32, cpu.PORTB_PCR16_ADDR);
var PIN1_PORT_PCR align(32) = @intToPtr(*volatile u32, cpu.PORTB_PCR17_ADDR);
var SIM_SCGC4 align(32) = @intToPtr(*volatile u32, cpu.SIM_SCGC4_ADDR);

var BASE_UART0 = @intToPtr(*volatile UART_MemMap, cpu.UART0_BASE_ADDR);

pub fn putchar(ch: u8) void {
    // Wait until space is available
    while ((BASE_UART0.S1 & cpu.UART_S1_TDRE_MASK) == 0) {}

    // Write character
    BASE_UART0.D = ch;
}

pub fn setup() void {
    PIN0_PORT_PCR.* = cpu.port_pcr_mux(3);
    PIN1_PORT_PCR.* = cpu.port_pcr_mux(3);
    SIM_SCGC4.* |= cpu.SIM_SCGC4_UART0_MASK;

    // Set defaults (8bit no parity)
    BASE_UART0.C1 = 0;

    // Set the baud rate. This has 3 components:
    //  BDH = Contains interrupt enable bits and the high 5 bits of the divisor
    //  BDL = Contains the low 8 bits of the divisor
    //  C4_BRFA = The fine adjust value
    //
    //  tx baud = module clock / (16 * (divisor + BRFA/32))
    const baud: comptime_int = 115200;
    const divisor: comptime_int = 72000000 / (baud * 16);
    const brfa: comptime_int = (2 * 72000000) / baud - divisor * 32;

    BASE_UART0.BDH = cpu.uart_bdh_sbr(divisor >> 8);
    BASE_UART0.BDL = cpu.uart_bdl_sbr(divisor);
    BASE_UART0.C4 = cpu.uart_c4_brfa(brfa);

    // Enable Tx
    BASE_UART0.C2 = cpu.UART_C2_TE_MASK;
}
