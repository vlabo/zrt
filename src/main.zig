const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.Uart;
const Systick = zrt.systick;

pub fn main() noreturn {
    var uart = Uart.new() catch {
        @panic("Failed to initialize uart");
    };
    var out = uart.get_out_stream();
    //var in = uart.get_in_stream();

    while (true) {
        out.print("Hello\n", .{}) catch {};
        time.delay(100);
    }
}
