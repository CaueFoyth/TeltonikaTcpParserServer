const std = @import("std");
const Parser = @import("parser/parser.zig").Parser;
const TeltonikaData = @import("model/teltonika_data.zig").TeltonikaData;
const imei_handler = @import("parser/teltonika/imei_handler.zig").imei_handler;

pub const TcpServer = struct {
    address: std.net.Address,
    server: std.net.Server,

    pub fn init(ip: []const u8, port: u16) !TcpServer {
        const address = try std.net.Address.parseIp(ip, port);
        const server = try address.listen(.{});
        return TcpServer{
            .address = address,
            .server = server,
        };
    }

    pub fn deinit(self: *TcpServer) void {
        self.server.deinit();
    }

    pub fn acceptAndHandle(self: *TcpServer, comptime handler: fn (TeltonikaData) void) !void {
        while (true) {
            const conn = try self.server.accept();
            defer conn.stream.close();

            std.debug.print("New connection from {}\n", .{conn.address});

            var buffer: [1024]u8 = undefined;
            const bytes_read = try conn.stream.read(&buffer);
            if (bytes_read <= 0) return;
            const packet_imei = buffer[0..bytes_read];

            const imei_int = imei_handler(packet_imei);
            std.debug.print("Recived IMEI: {}\n", .{imei_int});

            if (imei_int != 0) {
                _ = try conn.stream.write(&[_]u8{0x01});
            } else {
                _ = try conn.stream.write(&[_]u8{0x00});
                return;
            }

            var next_buffer: [1024]u8 = undefined;
            const next_bytes_read = try conn.stream.read(&next_buffer);
            var packet_data = next_buffer[0..next_bytes_read];

            if (packet_data.len == 0) {
                std.debug.print("Received empty packet data. Ignoring...\n", .{});
                continue;
            }

            if (next_bytes_read > 0) {
                std.debug.print("Teltonika Packet (hex): ", .{});
                for (packet_data) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});
            }

            std.debug.print("\n", .{});

            const sending = try Parser.init(&packet_data, imei_int);

            handler(sending);
        }
    }
};

pub fn defaultHandler(teltonika_data: TeltonikaData) void {
    std.debug.print("Received message of type {}:\n\n", .{teltonika_data});
}
