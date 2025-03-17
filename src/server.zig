const std: type = @import("std");
const Parser: type = @import("teltonika/parser.zig").Parser;
const TeltonikaData: type = @import("model/teltonika_data.zig").TeltonikaData;
const imei_handler = @import("teltonika/imei_handler.zig").imei_handler;
const isValidChecksum = @import("teltonika/validate_checksum.zig").isValidChecksum;

pub const TcpServer: type = struct {
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
            const bytes_read: usize = try conn.stream.read(&buffer);
            if (bytes_read <= 0) return;
            const packet_imei: []u8 = buffer[0..bytes_read];

            const imei_int: u64 = imei_handler(packet_imei);
            std.debug.print("Recived IMEI: {}\n", .{imei_int});

            switch (imei_int) {
                0 => {
                    _ = try conn.stream.write(&[_]u8{0x00});
                    continue;
                },
                else => {
                    _ = try conn.stream.write(&[_]u8{0x01});
                },
            }

            var next_buffer: [1024]u8 = undefined;
            const next_bytes_read: usize = try conn.stream.read(&next_buffer);
            var packet_data: []u8 = next_buffer[0..next_bytes_read];

            if (packet_data.len == 0) {
                std.debug.print("Received empty packet data. Ignoring...\n", .{});
                continue;
            }

            if (!isValidChecksum(packet_data)) {
                std.debug.print("Invalid checksum. Discarding packet.\n", .{});
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

            const sending: TeltonikaData = try Parser.init(&packet_data, imei_int);

            handler(sending);
        }
    }
};

pub fn defaultHandler(teltonika_data: TeltonikaData) void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const leak_status = gpa.deinit();
        if (leak_status != .ok) {
            std.log.err("Memory leak detected", .{});
        }
    }

    const json_string: []u8 = std.json.stringifyAlloc(allocator, teltonika_data, .{}) catch |err| {
        std.log.err("Error stringifying JSON: {s}", .{@errorName(err)});
        return;
    };
    defer allocator.free(json_string);

    std.log.info("JSON: {s}", .{json_string});
}
