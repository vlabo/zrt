pub const CpuFrequency = enum(u32) {
    F16MHz = 16_000_000, F24MHz = 24_000_000, F48MHz = 48_000_000, F72MHz = 72_000_000, F96MHz = 96_000_000
};

pub const frequency = CpuFrequency.F72MHz;

