const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;

pub const Targets = enum(comptime u32) {
    teensy,
};

pub const current: Targets = if (teensy3_2)
{
    return Targets.teensy;
} else {
    @compileError("Target not supported");
};
