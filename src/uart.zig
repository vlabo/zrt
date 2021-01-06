const io = @import("std").io;

pub fn UartTemplate(comptime setup: fn () bool, comptime read_char: fn () u8, comptime write_char: fn (u8) bool) type {
    return struct {
        const Self = @This();

        pub const Error = error{
            failed_to_initilize,
            failed_to_write,
            failed_to_read,
        };

        pub const OutStream = io.OutStream(Self, Error, Self.write_string);
        pub const InStream = io.InStream(Self, Error, Self.read_string);

        pub fn new() Error!Self {
            if (!setup()) {
                return Error.failed_to_initilize;
            }
            return Self{};
        }

        fn write_string(self: Self, string: []const u8) Error!usize {
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
}
