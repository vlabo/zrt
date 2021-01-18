const std = @import("std");
const zrt = @import("zrt.zig");
const time = zrt.Time;
const Uart = zrt.Uart;
const gpio = zrt.gpio;

var uart: Uart = undefined;
var led: gpio.Output = undefined;

var HeapMemory: [1024 * 10]u8 = undefined;
var FixedBufferAllocator: std.heap.FixedBufferAllocator = undefined; 

pub fn main() void {
    FixedBufferAllocator = std.heap.FixedBufferAllocator.init(&HeapMemory);
    uart = Uart.new() catch {
        @panic("Failed to open Uart.");
    };
    var out = uart.getOutStream();
    out.print("Startup\n", .{}) catch{};

    while(true) {
        out.print("Tick\n", .{}) catch {};
        time.sleep_s(1);
    }
}
