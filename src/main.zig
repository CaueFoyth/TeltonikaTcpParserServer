const std = @import("std");
const server_lib = @import("server_lib");

const BindConfig = struct {
    address: []const u8,
    port: u16,
};

comptime {
    _ = validateConfig(BIND_ADDRESS_DEFAULT, PORT_DEFAULT);
}

const BIND_ADDRESS_DEFAULT: []const u8 = "0.0.0.0";
const PORT_DEFAULT: u16 = 2202;

fn validateConfig(address: []const u8, port: u16) void {
    if (address.len == 0) @compileError("Bind address cannot be empty");
    if (port == 0) @compileError("Port must be non-zero");
}

const DEBUG = @import("builtin").mode == .Debug;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const config = blk: {
        if (args.len >= 3) {
            const address = args[1];
            const port = std.fmt.parseInt(u16, args[2], 10) catch PORT_DEFAULT;
            break :blk BindConfig{ .address = address, .port = port };
        }
        break :blk BindConfig{ .address = BIND_ADDRESS_DEFAULT, .port = PORT_DEFAULT };
    };

    var server = try server_lib.TcpServer.init(allocator, config.address, config.port);
    defer server.deinit();

    if (DEBUG) {
        std.debug.print("Server is running on {s}:{d}...\n", .{ config.address, config.port });
    }

    try server.start(server_lib.defaultHandler);

    while (true) {
        std.time.sleep(1 * std.time.ns_per_s);
    }
}
