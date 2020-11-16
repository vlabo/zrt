const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const builtin = @import("builtin");
const CrossTarget = std.zig.CrossTarget;
const panic = std.debug.panic;

const stdout = std.io.getStdOut().outStream();

pub fn build(b: *Builder) !void {
    const teensy = b.option(bool, "teensy", "Build for teensy 3.2") orelse true;

    const firmware = b.addExecutable("firmware", "src/zrt.zig");
    firmware.addBuildOption(bool, "teensy3_2", teensy);

    if (teensy) {
        try teensyBuild(b, firmware);
    } else {
        panic("Target not supported", .{});
    }

    b.default_step.dependOn(&firmware.step);
}

fn teensyBuild(b: *Builder, firmware: *LibExeObjStep) !void {
    try stdout.print("Building for teensy 3.2\n", .{});

    const target = CrossTarget{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
    };

    firmware.setTarget(target);
    firmware.setLinkerScriptPath("src/teensy3_2/link/mk20dx256.ld");
    firmware.setOutputDir("zig-cache");
    firmware.setBuildMode(builtin.Mode.ReleaseSmall);

    const hex = b.step("hex", "Convert to hex");
    const upload = b.step("upload", "Upload");
    const dis = b.step("dis", "Disassembly");

    var objcopy_args = std.ArrayList([]const u8).init(b.allocator);
    try objcopy_args.appendSlice(&[_][]const u8{
        "llvm-objcopy",
        "-O",
        "ihex",
        "-R",
        ".eeprom",
        "-B",
        "arm",
        firmware.getOutputPath(),
        "output.hex",
    });
    const create_hex = b.addSystemCommand(objcopy_args.items);
    create_hex.step.dependOn(&firmware.step);
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


    var disassembly_args = std.ArrayList([]const u8).init(b.allocator);
    try disassembly_args.appendSlice(&[_][]const u8{
        "objdump",
        "-d",
        "zig-cache/firmware",
    });
    const disassembly = b.addSystemCommand(disassembly_args.items);
    disassembly.step.dependOn(&firmware.step);
    dis.dependOn(&disassembly.step);
}
