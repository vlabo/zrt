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

fn task() void {
    var out = uart.getOutStream();
    while (true) {
        out.print("0", .{}) catch {};
        led.toggle();
        rt.taskDelay(1000);
    }
}

fn task2() void {
    var out = uart.getOutStream();
    while (true) {
        out.print("1", .{}) catch {};
        led.toggle();
        rt.taskDelay(387);
    }
}

pub fn main() void {
    FixedBufferAllocator = std.heap.FixedBufferAllocator.init(&HeapMemory);
    heap.initAllocator(&FixedBufferAllocator.allocator);
    uart = Uart.new() catch {
        @panic("Failed to open Uart.");
    };
    var out = uart.getOutStream();
    out.print("Starting up...\n", .{}) catch {};

    led = gpio.Output.new(13);

    rt.createTask(task, "task", 0) catch {
        out.print("Failed to create task1", .{}) catch {};
    };
    rt.createTask(task2, "task2", 0) catch {
        out.print("Failed to create task2", .{}) catch {};
    };

    rt.startSchedular();
}
