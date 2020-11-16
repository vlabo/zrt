const cpu = @import("mk20dx256.zig");
const io = @import("std").io;

var setup_complete = false;

pub const Uart = struct {
    const Self = @This();

    pub const Error = error{
        failed_to_write,
        failed_to_read,
    };

    pub const OutStream = io.OutStream(Self, Error, Self.write_string);
    pub const InStream = io.InStream(Self, Error, Self.read_string);

    pub fn new() Self {
        if (!setup_complete) {
            Self.setup();
        }
        return Self{};
    }

    pub fn setup() void {
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
        const divisor: comptime_int = 72000000 / (baud * 16);
        const brfa: comptime_int = (2 * 72000000) / baud - divisor * 32;

        cpu.Uart0.BDH = cpu.uart_bdh_sbr(divisor >> 8);
        cpu.Uart0.BDL = cpu.uart_bdl_sbr(divisor);
        cpu.Uart0.C4 = cpu.uart_c4_brfa(brfa);

        // Enable Tx and Rx
        cpu.Uart0.C2 = cpu.UART_C2_TE_MASK | cpu.UART_C2_RE_MASK;
    }

    fn write_string(self: Self, string: []const u8) Error!usize {
        for (string) |value| {
            if (value == '\n') {
                Self.write_char('\r');
            }
            Self.write_char(value);
        }
        return string.len;
    }

    fn write_char(ch: u8) void {
        // Wait until space is available
        while ((cpu.Uart0.S1 & cpu.UART_S1_TDRE_MASK) == 0) {
            cpu.nop();
        }

        // Write character
        cpu.Uart0.D = ch;
    }

    fn read_char() u8 {
        // Wait until character is recived
        while ((cpu.Uart0.S1 & cpu.UART_S1_RDRF_MASK) == 0) {
            cpu.nop();
        }

        // Read char
        return cpu.Uart0.D;
    }

    fn read_string(self: Self, buffer: []u8) Error!usize {
        for (buffer) |value, index| {
            var char = Self.read_char();
            buffer[index] = char;
        }

        return buffer.len;
    }

    pub fn get_out_stream(self: Self) OutStream {
        return OutStream{ .context = self };
    }

    pub fn get_in_stream(self: Self) InStream {
        return InStream{ .context = self };
    }
};
