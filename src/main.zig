const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.uart.Uart;

pub fn main() void {
    var uart = Uart.new();
    var out = uart.get_out_stream();

    while (true) {
        out.print("Micro:bit\n", .{}) catch {};
        time.delay(1000);
    }
}
