const zrt = @import("zrt.zig");
const time = zrt.Time;
const Uart = zrt.Uart;

pub fn main() void {
    var uart = Uart.new() catch { @panic("Failed to open Uart."); };
    var out = uart.getOutStream();

    while (true) {
        out.print("Writing\n", .{}) catch {};
        time.sleep_ms(1000);
    }
}
