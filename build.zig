const std = @import("std");
const Builder = std.build.Builder;
const builtin = @import("builtin");
const CrossTarget = std.zig.CrossTarget;

pub fn build(b: *Builder) !void {
    const target = CrossTarget{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
    };

    const kernel = b.addExecutable("kernel", "src/main.zig");

    const lib_cflags = &[_][]const u8{"-Wall", "-Os", "-mthumb", "-ffunction-sections", "-fdata-sections", "-nostdlib"};
    for (common_c_files) |src_file| {
        kernel.addCSourceFile(src_file, lib_cflags);
    }
    kernel.addIncludeDir("./c_src");

    kernel.setTarget(target);
    kernel.setLinkerScriptPath("mk20dx256.ld");
    kernel.setOutputDir("zig-cache");
    kernel.setBuildMode(builtin.Mode.ReleaseSmall);
    // kernel.installRaw("output.bin");

    const hex = b.step("hex", "Convert to hex");
    const upload = b.step("upload", "Upload");

    var objcopy_args = std.ArrayList([]const u8).init(b.allocator);
    try objcopy_args.appendSlice(&[_][]const u8{
        "llvm-objcopy",
        "-O",
        "ihex",
        "-R",
        ".eeprom",
        "-B",
        "arm",
        kernel.getOutputPath(),
        "output.hex",
    });
    const create_hex = b.addSystemCommand(objcopy_args.items);
    create_hex.step.dependOn(&kernel.step);
    hex.dependOn(&create_hex.step);

    var teensy_upload_args = std.ArrayList([]const u8).init(b.allocator);
    try teensy_upload_args.appendSlice(&[_][]const u8{
        "./teensy_loader_cli",
        "--mcu=mk20dx256",
        "-w",
        "output.hex",
    });
    const teensy_upload = b.addSystemCommand(teensy_upload_args.items);
    teensy_upload.step.dependOn(&create_hex.step);
    upload.dependOn(&teensy_upload.step);

    b.default_step.dependOn(&kernel.step);
}

const common_c_files = [_][]const u8 {
    "./c_src/functions.c",
    "./c_src/delay.c",
    "./c_src/interrupt.c",
    "./c_src/startup.c",
    "./c_src/systick.c",
    "./c_src/uart.c",
    "./c_src/watchdog.c",
};