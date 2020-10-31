const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.uart.Uart;

pub fn main() noreturn {
    var uart = Uart.new();
    var out = uart.get_out_stream();
    var led = gpio.Output.new(5);

    var i: u32 = 0;
    while (true) {
        led.toggle();
        time.delay(900);
        out.print("led is on:  {}\n", .{i}) catch {};

        led.toggle();
        time.delay(100);
        out.print("led is off: {}\n", .{i}) catch {};

        i += 1;
    }
}
