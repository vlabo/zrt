const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const builtin = @import("builtin");
const CrossTarget = std.zig.CrossTarget;
const panic = std.debug.panic;

const stdout = std.io.getStdOut().outStream();

pub fn build(b: *Builder) !void {
    const teensy = b.option(bool, "teensy", "Build for teensy 3.2") orelse false;
    const microbit = b.option(bool, "microbit", "Build for micro:bit") orelse true;

    const firmware = b.addExecutable("firmware", "src/zrt.zig");
    firmware.addBuildOption(bool, "teensy3_2", teensy);
    firmware.addBuildOption(bool, "microbit", microbit);

    if (teensy) {
        try teensyBuild(b, firmware);
    } else if (microbit) {
        try microbitBuild(b, firmware);
    } else {
        panic("Target not supported", .{});
    }

    b.default_step.dependOn(&firmware.step);
}

fn teensyBuild(b: *Builder, firmware: *LibExeObjStep) !void {
    try stdout.print("Building for teensy 3.2\n", .{});

    firmware.addCSourceFile("src/c/task.c", &[_][]const u8{});

    const target = CrossTarget{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m4 },
    };
    // const lib_cflags = &[_][]const u8{ "-Wall", "-Os", "-mthumb", "-ffunction-sections", "-fdata-sections", "-nostdlib" };
    firmware.setTarget(target);
    // firmware.addCSourceFile("src/c/TeensyThreads-asm.S", lib_cflags);
    firmware.setLinkerScriptPath("src/teensy3_2/link/mk20dx256.ld");
    firmware.setOutputDir("zig-cache");
    firmware.setBuildMode(builtin.Mode.ReleaseSmall);

    const hex = b.step("hex", "Convert to hex");
    const upload = b.step("upload", "Upload");
    const dis = b.step("dis", "Disassemble");

    var objcopy_args = generateHexArguments(b, firmware.getOutputPath());
    const create_hex = b.addSystemCommand(objcopy_args.items);
    create_hex.step.dependOn(&firmware.step);
    hex.dependOn(&create_hex.step);

    var disassemble_args = generateDissasembleArguments(b, firmware.getOutputPath());
    const run_disassemble = b.addSystemCommand(disassemble_args.items);
    dis.dependOn(&run_disassemble.step);

    var teensy_upload_args = generateTeensyUploadArguments(b);
    const teensy_upload = b.addSystemCommand(teensy_upload_args.items);
    teensy_upload.step.dependOn(&create_hex.step);
    upload.dependOn(&teensy_upload.step);
}

fn microbitBuild(b: *Builder, firmware: *LibExeObjStep) !void {
    try stdout.print("Building for microbit\n", .{});

    const target = CrossTarget{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0 },
    };

    firmware.setTarget(target);
    firmware.setLinkerScriptPath("src/microbit/link/nRF51.ld");
    firmware.setOutputDir("zig-cache");
    firmware.setBuildMode(builtin.Mode.Debug);

    const hex = b.step("hex", "Convert to hex");
    const dis = b.step("dis", "Disassemble");
    const qemu = b.step("qemu", "Run the firmware in qemu");
    const qemu_debug = b.step("qemu_debug", "Run the firmware in qemu and wait for debugger");

    var qemu_args = generateQemuArguments(b, "arm.exe", "microbit", firmware.getOutputPath());
    const run_qemu = b.addSystemCommand(qemu_args.items);
    qemu.dependOn(&firmware.step);
    qemu.dependOn(&run_qemu.step);
    
    var qemu_debug_args = generateQemuDebugArguments(b, "arm.exe", "microbit", firmware.getOutputPath());
    const run_qemu_debug = b.addSystemCommand(qemu_debug_args.items);
    qemu_debug.dependOn(&firmware.step);
    qemu_debug.dependOn(&run_qemu_debug.step);

    var disassemble_args = generateDissasembleArguments(b, firmware.getOutputPath());
    const run_disassemble = b.addSystemCommand(disassemble_args.items);
    dis.dependOn(&firmware.step);
    dis.dependOn(&run_disassemble.step);

    var objcopy_args = generateHexArguments(b, firmware.getOutputPath());
    const create_hex = b.addSystemCommand(objcopy_args.items);
    create_hex.step.dependOn(&firmware.step);
    hex.dependOn(&create_hex.step);
}

fn generateHexArguments(b: *Builder, firmwarePath: []const u8) std.ArrayList([]const u8) {
    var objcopy_args = std.ArrayList([]const u8).init(b.allocator);
    objcopy_args.appendSlice(&[_][]const u8{
        "llvm-objcopy-9",
        "-O",
        "ihex",
        "-R",
        ".eeprom",
        "-B",
        "arm",
        firmwarePath,
        "output.hex",
    }) catch {
        unreachable;
    };
    return objcopy_args;
}

fn generateQemuArguments(b: *Builder, comptime arch: []const u8, machine: []const u8, firmwarePath: []const u8) std.ArrayList([]const u8) {
    var qemu_args = std.ArrayList([]const u8).init(b.allocator);
    qemu_args.appendSlice(&[_][]const u8{
        "qemu-system-" ++ arch,
        "-kernel",
        firmwarePath,
        "-M",
        machine,
        "-serial",
        "stdio",
        "-display",
        "none",
    }) catch {
        unreachable;
    };
    return qemu_args;
}

fn generateQemuDebugArguments(b: *Builder, comptime arch: []const u8, machine: []const u8, firmwarePath: []const u8) std.ArrayList([] const u8) {
    var qemu_args = std.ArrayList([]const u8).init(b.allocator);
    qemu_args.appendSlice(&[_][]const u8{
        "qemu-system-" ++ arch,
        "-kernel",
        firmwarePath,
        "-M",
        machine,
        "-serial",
        "stdio",
        "-display",
        "none",
        "-s",
        "-S",
    }) catch {
        unreachable;
    };
    return qemu_args;
}

fn generateTeensyUploadArguments(b: *Builder) std.ArrayList([]const u8) {
    var teensy_upload_args = std.ArrayList([]const u8).init(b.allocator);
    teensy_upload_args.appendSlice(&[_][]const u8{
        "sudo",
        "./uploader",
        "--mcu=mk20dx256",
        "-w",
        "output.hex",
    }) catch {
        unreachable;
    };
    return teensy_upload_args;
}

fn generateDissasembleArguments(b: *Builder, firmwarePath: []const u8) std.ArrayList([]const u8) {
    var objdump_args = std.ArrayList([]const u8).init(b.allocator);
    objdump_args.appendSlice(&[_][]const u8{
        "llvm-objdump-9",
        "-d",
        firmwarePath,
    }) catch {
        unreachable;
    };
    return objdump_args;
}