const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.uart.Uart;

fn clear_line(out: Uart.OutStream) !void {
    try out.print("\r                                                    \r", .{});
}

pub fn main() noreturn {
    var uart = Uart.new();
    var out = uart.get_out_stream();
    var in = uart.get_in_stream();
    var led = gpio.Output.new(5);

    while (true) {
        led.set_low();
        var ch = in.readByte() catch ' ';
        led.set_high();
        if(ch == 127) {
            clear_line(out) catch {};
        } else {
            out.print("{c}", .{ch}) catch {};
        }
        time.delay(1);
    }
}
