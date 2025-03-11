const std = @import("std");
const Parser = @import("parser/parser.zig").Parser;

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

    pub fn acceptAndHandle(self: *TcpServer, comptime handler: fn ([]const u8) void) !void {
        while (true) {
            const conn = try self.server.accept();
            defer conn.stream.close();

            std.debug.print("New connection from {}\n", .{conn.address});

            var buffer: [1024]u8 = undefined;
            const bytes_read = try conn.stream.read(&buffer);
            if (bytes_read <= 0) return;
            const packet_imei = buffer[0..bytes_read];

            const imei_int = Parser.imei_handler(packet_imei);
            std.debug.print("Recived IMEI: {}\n", .{imei_int});

            if (imei_int != 0) {
                _ = try conn.stream.write(&[_]u8{0x01});
            } else {
                _ = try conn.stream.write(&[_]u8{0x00});
                return;
            }

            var teltonika_data = Parser.TeltonikaData.init(imei_int);

            var next_buffer: [1024]u8 = undefined;
            const next_bytes_read = try conn.stream.read(&next_buffer);
            var packet_data = next_buffer[0..next_bytes_read];

            if (next_bytes_read > 0) {
                std.debug.print("Próximos bytes recebidos (hex): ", .{});
                for (packet_data) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});
            }

            std.debug.print("\n", .{});

            if (packet_data.len < 4) return;
            teltonika_data.preamble = try Parser.parsePreamble(&packet_data);
            packet_data = packet_data[4..];

            if (packet_data.len < 4) return;
            teltonika_data.data_size = try Parser.parseDataField(&packet_data);
            packet_data = packet_data[4..];

            if (packet_data.len < 1) return;
            teltonika_data.codec_id = try Parser.parseCodecId(&packet_data);
            packet_data = packet_data[1..];

            if (packet_data.len < 1) return;
            teltonika_data.number_data = try Parser.parseNumberData(&packet_data, 1);
            packet_data = packet_data[1..];

            if (packet_data.len <= 4) return;
            teltonika_data.crc16 = try Parser.parseCrc16(&packet_data);
            packet_data = packet_data[0 .. packet_data.len - 4];

            if (packet_data.len < 1) return;
            teltonika_data.number_data_2 = try Parser.parseNumberData(&packet_data, 2);
            packet_data = packet_data[0 .. packet_data.len - 1];

            if (packet_data.len <= 8) return;
            teltonika_data.timestamp = try Parser.parseTimestamp(&packet_data);
            packet_data = packet_data[8..];

            if (packet_data.len < 1) return;
            teltonika_data.priority = try Parser.parsePriority(&packet_data);
            packet_data = packet_data[1..];

            handler(packet_data);
        }
    }
};

pub fn defaultHandler(message: []const u8) void {
    std.debug.print("Received message: {x:0>2}\n\n", .{message});
}
