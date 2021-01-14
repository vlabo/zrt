usingnamespace @cImport({
    @cInclude("zig_interface.h");
});

pub const Error = error{
    failed_to_allocate_memory,
};

pub fn createTask(task: fn() void, name: []const u8, priority: u32) !void {
    var err = rtTaskCreate(@ptrCast(fn() callconv(.C) void, task), @ptrCast([*c]const u8, name), priority);
    if(err != 1) {
        return Error.failed_to_allocate_memory;
    }
}

pub fn startSchedular() void {
    rtStartSchedular();
}

pub fn taskDelay(ticks: u32) void {
    rtTaskDelay(ticks);
}