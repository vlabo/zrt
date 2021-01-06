pub inline fn nop() void {
    asm volatile ("nop");
}

pub inline fn wfe() void {
    asm volatile ("wfe");
}

pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn get_cpu_id() usize {
    return get_system_value("mpidr_el1");
}

pub inline fn get_counter_timer_freq() usize {
    return get_system_value("cntfrq_el0");
}

pub inline fn get_counter_timer() usize {
    return get_system_value("cntpct_el0");
}

pub inline fn get_system_value(comptime name: []const u8) usize {
    return asm volatile ("mrs %[value], " ++ name
        : [value] "=r" (-> usize)
    );
}
