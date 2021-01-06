const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const builtin = @import("builtin");
const CrossTarget = std.zig.CrossTarget;
const panic = std.debug.panic;

const stdout = std.io.getStdOut().outStream();

pub fn build(b: *Builder) !void {
    const teensy = b.option(bool, "teensy", "Build for teensy 3.2") orelse false;
    const raspberry = b.option(bool, "raspberry", "Build for teensy 3.2") orelse true;

    const firmware = b.addExecutable("firmware", "src/zrt.zig");
    firmware.addBuildOption(bool, "teensy3_2", teensy);
    firmware.addBuildOption(bool, "raspberry", raspberry);

    if (teensy) {
        try teensyBuild(b, firmware);
    } else if (raspberry) {
        try raspberryBuild(b, firmware);
    } else {
        panic("Target not supported", .{});
    }

    b.default_step.dependOn(&firmware.step);
}

fn raspberryBuild(b: *Builder, firmware: *LibExeObjStep) !void {
    try stdout.print("Building for Raspberry pi 3B\n", .{});

    const target = CrossTarget{
        .cpu_arch = .aarch64,
        .os_tag = .freestanding,
        .cpu_model = .{ .explicit = &std.Target.aarch64.cpu.cortex_a53 },
    };
    firmware.setTarget(target);
    firmware.setLinkerScriptPath("src/raspberry/link/cortex-a.ld");
    firmware.setOutputDir("zig-cache");
    firmware.setBuildMode(builtin.Mode.ReleaseFast);

    const qemu = b.step("qemu", "Run the firmware in qemu");
    const dis = b.step("dis", "Disassemble");

    var qemu_args = std.ArrayList([]const u8).init(b.allocator);
    try qemu_args.appendSlice(&[_][]const u8{
        "qemu-system-aarch64",
        "-kernel",
        firmware.getOutputPath(),
        "-M",
        "raspi3",
        "-serial",
        "stdio",
        "-display",
        "none",
        "-s",
        // "-S",
    });

    const run_qemu = b.addSystemCommand(qemu_args.items);
    qemu.dependOn(&run_qemu.step);

    var dis_args = std.ArrayList([]const u8).init(b.allocator);
    try dis_args.appendSlice(&[_][]const u8{
        "llvm-objdump",
        "-d",
        firmware.getOutputPath(),
    });

    const run_dis = b.addSystemCommand(dis_args.items);
    dis.dependOn(&run_dis.step);

    run_qemu.step.dependOn(&firmware.step);
    run_dis.step.dependOn(&firmware.step);
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
        "sudo",
        "./uploader",
        "--mcu=mk20dx256",
        "-w",
        "output.hex",
    });
    const teensy_upload = b.addSystemCommand(teensy_upload_args.items);
    teensy_upload.step.dependOn(&create_hex.step);
    upload.dependOn(&teensy_upload.step);
}
