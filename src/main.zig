const std = @import("std");
const zrt = @import("zrt.zig");
const time = zrt.Time;
const Uart = zrt.Uart;
const gpio = zrt.gpio;
const rt = @import("rtos/rt.zig");
const heap = @import("rtos/heap.zig");

var uart: Uart = undefined;
var led: gpio.Output = undefined;

var HeapMemory: [1024 * 10]u8 = undefined;
var FixedBufferAllocator: std.heap.FixedBufferAllocator = undefined; 

export fn task() void {
    var out = uart.getOutStream();

    while (true) {
        led.toggle();
        rt.taskDelay(1000);
    }
}

export fn task2() void {
    var out = uart.getOutStream();

    while (true) {
        led.toggle();
        rt.taskDelay(10);
        led.toggle();
        rt.taskDelay(100);
    }
}

pub fn main() void {
    FixedBufferAllocator = std.heap.FixedBufferAllocator.init(&HeapMemory);
    heap.initAllocator(&FixedBufferAllocator.allocator);
    uart = Uart.new() catch {
        @panic("Failed to open Uart.");
    };
    var out = uart.getOutStream();
    out.print("startup\n", .{}) catch{};
    led = gpio.Output.new(13);
   
    _ = rt.createTask(&FixedBufferAllocator.allocator, task, 512) catch {
        out.print("Failed to create task1", .{}) catch { return undefined; };
    };

    _ = rt.createTask(&FixedBufferAllocator.allocator, task2, 512) catch {
        out.print("Failed to create task1", .{}) catch { return undefined; };
    };

    rt.startSchedular(&FixedBufferAllocator.allocator) catch {};
}
