const std = @import("std");
const interrupt = @import("../teensy3_2/interrupt.zig");
const time = @import("../teensy3_2/time.zig");

pub const Error = error{
    failed_to_allocate_memory,
};

const TaskControlBlock = struct
{
    topOfStack: usize,
    stack: []u32,
};

// C Exports
export var pxCurrentTCB: ?*volatile TaskControlBlock = null;

// Extern C Functions
extern fn pxPortInitialiseStack(topOfStack: usize, task: fn() callconv(.C) void, parameters: usize) callconv(.C) usize;
extern fn xPortStartScheduler() callconv(.C) void;
extern fn yield() callconv(.C) void;

var Tasks: [10]*TaskControlBlock = undefined;
var TasksCount: u8 = 0;
var CurrentTaskIndex: u8 = 0;

pub fn createTask(allocator: *std.mem.Allocator, task: fn() callconv(.C) void, stackSize: u16) !*TaskControlBlock {

    if(TasksCount >= Tasks.len) {
        return Error.failed_to_allocate_memory;
    }

    var stack = allocator.alloc(u32, stackSize) catch {
        return Error.failed_to_allocate_memory;
    };
    
    var newTCB = allocator.create(TaskControlBlock) catch {
        allocator.free(stack);
        return Error.failed_to_allocate_memory;
    };

    newTCB.stack = stack;

    std.mem.set(u32, newTCB.stack, 0);
    newTCB.topOfStack = @ptrToInt(&newTCB.stack[newTCB.stack.len - 1]);

    var index: u32 = 0;
    newTCB.topOfStack = pxPortInitialiseStack(newTCB.topOfStack, task, 0);

    Tasks[TasksCount] = newTCB;
    TasksCount += 1;
    return newTCB;
}

pub fn startSchedular(allocator: *std.mem.Allocator) !void {
    interrupt.disable();
    pxCurrentTCB = Tasks[CurrentTaskIndex];
    xPortStartScheduler();
}

export fn vTaskSwitchContext() void {
    CurrentTaskIndex += 1;
    CurrentTaskIndex %= TasksCount;
    pxCurrentTCB = Tasks[CurrentTaskIndex];
}

pub fn taskDelay(ticks: u32) void {
    yield();
    time.sleep_ms(ticks);
}

export fn xTaskIncrementTick() i32 {
    return 1;
}