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

    const cflags = [_][]const u8{
        "-Isrc/c/ARM_CM4F",
        "-Isrc/c/include",
    };
    
    const c_files = [_][]const u8{
        "src/c/src/zig_interface.c",
        "src/c/ARM_CM4F/port.c",
        "src/c/src/usb.c",
        "src/c/src/buffers.c",
        "src/c/src/arm_cm4.c",
    };

    for (c_files) |c_file| {
        firmware.addCSourceFile(c_file, &cflags);
    }
    firmware.addIncludeDir("src/c/include");

    const hex = b.step("hex", "Convert to hex");
    const upload = b.step("upload", "Upload");
    const dis = b.step("dis", "Disassemble");

    var objcopy_args = generateHexArguments(b, firmware.getOutputPath());
    const create_hex = b.addSystemCommand(objcopy_args.items);
    create_hex.step.dependOn(&firmware.step);
    hex.dependOn(&create_hex.step);

    var disassemble_args = generateDissasembleArguments(b, firmware.getOutputPath());
    const run_disassemble = b.addSystemCommand(disassemble_args.items);
    run_disassemble.step.dependOn(&firmware.step);
    dis.dependOn(&run_disassemble.step);

    var teensy_upload_args = generateTeensyUploadArguments(b);
    const teensy_upload = b.addSystemCommand(teensy_upload_args.items);
    teensy_upload.step.dependOn(&create_hex.step);
    upload.dependOn(&teensy_upload.step);

    b.default_step.dependOn(hex);
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