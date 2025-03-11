const std = @import("std");
const lib = @import("TeltonikaTcpParserServer_lib");

const server_lib = @import("server_lib");

pub fn main() !void {
    var server = try server_lib.TcpServer.init("0.0.0.0", 2202);
    defer server.deinit();

    std.debug.print("Server is running on port 2202...\n", .{});

    try server.acceptAndHandle(server_lib.defaultHandler);
}
