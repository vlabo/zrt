const std = @import("std");
const Allocator = std.mem.Allocator;

const zrt = @import("../zrt.zig");
const Uart = zrt.Uart;

var rtAllocator: *Allocator = undefined;

var uart: Uart = undefined;

pub fn initAllocator(allocator: *Allocator) void {
    rtAllocator = allocator;
    uart = Uart.new() catch {
        @panic("Failed to open Uart.");
    };
}

export fn pvPortMalloc(size: usize) usize {
    var out = uart.getOutStream();
    out.print("allocating: {} bytes\n", .{size}) catch {};
    var mem = rtAllocator.alloc(u8, size) catch {
        out.print("Failed to allocate\n", .{}) catch {};
        return 0;
    };
    const memP: usize = @ptrToInt(&mem[0]);
    out.print("allocated 0x{x}\n", .{memP}) catch {};

    return memP;
}

export fn vPortFree(pointer: usize) void {
    var out = uart.getOutStream();
    out.print("freeing memory: 0x{x} \n", .{pointer}) catch {};
    rtAllocator.free(@intToPtr(*[]u8, pointer).*);
}

export fn vPortInitialiseBlocks() void {}

export fn xPortGetFreeHeapSize() usize {
    return 0;
}
