const io = @import("std").io;

pub fn UartTemplate(comptime setup: fn () bool, comptime read_char: fn () u8, comptime write_char: fn (u8) bool) type {
    return struct {
        const Self = @This();

        pub const Error = error{
            failed_to_initilize,
            failed_to_write,
            failed_to_read,
        };

        pub const OutStream = io.OutStream(Self, Error, Self.writeString);
        pub const InStream = io.InStream(Self, Error, Self.readString);

        pub fn new() Error!Self {
            if (!setup()) {
                return Error.failed_to_initilize;
            }
            return Self{};
        }

        fn writeString(self: Self, string: []const u8) Error!usize {
            for (string) |value| {
                if (value == '\n') {
                    if (!write_char('\r')) {
                        return Error.failed_to_write;
                    }
                }
                if (!write_char(value)) {
                    return Error.failed_to_write;
                }
            }
            return string.len;
        }

        fn readString(self: Self, buffer: []u8) Error!usize {
            for (buffer) |value, index| {
                var char = Self.read_char();
                buffer[index] = char;
            }

            return buffer.len;
        }

        pub fn getOutStream(self: Self) OutStream {
            return OutStream{ .context = self };
        }

        pub fn getInStream(self: Self) InStream {
            return InStream{ .context = self };
        }
    };
}

pub fn TimeTemplate(comptime sleep_ms: fn (ms: u64) void) type {
    return struct {
        pub fn sleep_ms(ms: u64) void {
            sleep_ms(ms);
        }
        pub fn sleep_s(s: u64) void {
            sleep_ms(s * 1000);
        }
    };
}
