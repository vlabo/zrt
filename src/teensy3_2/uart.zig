const cpu = @import("mk20dx256.zig");
const config = @import("config.zig");

var isInitialized = false;

pub fn setup() bool {
    if(!isInitialized) {
        cpu.PortB.controlRegister[16] = cpu.port_pcr_mux(3);
        cpu.PortB.controlRegister[17] = cpu.port_pcr_mux(3);
        cpu.System.ClockGating4.* |= cpu.SIM_SCGC4_UART0_MASK;

        // Set defaults (8bit no parity)
        cpu.Uart0.C1 = 0;

        // Set the baud rate. This has 3 components:
        //  BDH = Contains interrupt enable bits and the high 5 bits of the divisor
        //  BDL = Contains the low 8 bits of the divisor
        //  C4_BRFA = The fine adjust value
        //
        //  tx baud = module clock / (16 * (divisor + BRFA/32))
        const baud: comptime_int = 115200;
        const divisor: comptime_int = @enumToInt(config.frequency) / (baud * 16);
        const brfa: comptime_int = (2 * @enumToInt(config.frequency)) / baud - divisor * 32;

        cpu.Uart0.BDH = cpu.uart_bdh_sbr(divisor >> 8);
        cpu.Uart0.BDL = cpu.uart_bdl_sbr(divisor);
        cpu.Uart0.C4 = cpu.uart_c4_brfa(brfa);

        // Enable Tx and Rx
        cpu.Uart0.C2 = cpu.UART_C2_TE_MASK | cpu.UART_C2_RE_MASK;
        isInitialized = true;
    }
    return true;
}

pub fn write_char(ch: u8) bool {
    // Wait until space is available
    while ((cpu.Uart0.S1 & cpu.UART_S1_TDRE_MASK) == 0) {
        cpu.nop();
    }

    // Write character
    cpu.Uart0.D = ch;
    return true;
}

pub fn read_char() u8 {
    // Wait until character is recived
    while ((cpu.Uart0.S1 & cpu.UART_S1_RDRF_MASK) == 0) {
        cpu.nop();
    }

    // Read char
    return cpu.Uart0.D;
}
