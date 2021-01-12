const cpu = @import("nRF51.zig");
const io = @import("std").io;

pub const Uart = struct {
    const Self = @This();

    pub const Error = error{
        failed_to_write,
        failed_to_read,
    };

    pub const OutStream = io.OutStream(Self, Error, Self.write_string);
    pub const InStream = io.InStream(Self, Error, Self.read_string);

    pub fn new() Self {
        Self.setup();
        return Self{};
    }

    pub fn setup() void {
        cpu.GPIO.directionSet = 1 << 24;
        cpu.UartSetup.boundRate = 0x01D7E000; // 115200
        cpu.UartSetup.pinSelectTxd = 24;
        cpu.UartSetup.enable = 4;
        cpu.UartState.startTx = 1;
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
        // Write character
        cpu.UartSetup.txd = ch;
        
        // Wait until space is available
        while (cpu.UartEvents.txReady != 0) {}
    }

    fn read_char() u8 {
        return 0;
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
