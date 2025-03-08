const std = @import("std");
const lib = @import("TeltonikaTcpParserServer_lib");

// Importa a biblioteca do root.zig com o novo nome
const server_lib = @import("server_lib");

pub fn main() !void {
    // Configura e inicia o servidor
    var server = try server_lib.TcpServer.init("0.0.0.0", 2202);
    defer server.deinit();

    std.debug.print("Servidor rodando na porta 2202...\n", .{});

    // Usa o handler padrão ou um personalizado
    try server.acceptAndHandle(server_lib.defaultHandler);
}
