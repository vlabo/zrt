pub const CpuFrequency = enum(u32) {
    F72MHz = 72_000_000, // Only 72MHz is supported for now
};

pub const frequency = CpuFrequency.F72MHz;
