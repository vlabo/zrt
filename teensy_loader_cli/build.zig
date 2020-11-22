const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("teensy_loader_cli", null);
    const lib_cflags = &[_][]const u8{ "-Wall", "-Ofast", "-DUSE_LIBUSB" };
    exe.addCSourceFile("teensy_loader_cli.c", lib_cflags);
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("usb");
    exe.install();

    exe.setTarget(target);
    exe.setBuildMode(mode);
    b.default_step.dependOn(&exe.step);
}
