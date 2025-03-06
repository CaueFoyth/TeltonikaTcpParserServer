const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.createModule(.{
        .root_source_file = b.path("src/server.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Módulo do executável (main.zig)
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Adiciona a dependência do executável na biblioteca
    exe_mod.addImport("server_lib", lib_mod);

    // Se TeltonikaTcpParserServer_lib for uma dependência externa ou outro arquivo,
    // você pode adicioná-la como módulo aqui. Por exemplo:
    // const teltonika_lib = b.createModule(.{
    //     .root_source_file = b.path("src/TeltonikaTcpParserServer_lib.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    // exe_mod.addImport("TeltonikaTcpParserServer_lib", teltonika_lib);

    // Biblioteca estática (opcional)
    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "TeltonikaTcpParserServer-lib", // Nome diferenciado para evitar conflito
        .root_module = lib_mod,
    });
    b.installArtifact(lib);

    // Executável
    const exe = b.addExecutable(.{
        .name = "TeltonikaTcpParserServer", // Nome do executável
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    // Passo para rodar o executável
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // Testes da biblioteca
    const lib_unit_tests = b.addTest(.{
        .root_module = lib_mod,
    });
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    // Testes do executável
    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // Passo para rodar os testes
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
}