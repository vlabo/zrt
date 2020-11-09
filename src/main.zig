const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.uart.Uart;
const Systick = zrt.systick;

extern var _sbss: u8;
extern var _ebss: u8;
pub fn main() noreturn {
    var uart = Uart.new();
    var out = uart.get_out_stream();
    var in = uart.get_in_stream();
    // var led = gpio.Output.new(13);
    // var led1 = gpio.Output.new(23);
    // var input = gpio.Input.new(14);

    out.print("bss: {} - {} = {}\n", .{ @ptrToInt(&_ebss), @ptrToInt(&_sbss), @ptrToInt(&_ebss) - @ptrToInt(&_sbss) }) catch {};

    while (true) {
        time.delay(100);
    }
}
