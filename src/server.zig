const std = @import("std");
const Parser = @import("teltonika/parser.zig").Parser;
const TeltonikaData = @import("model/teltonika_data.zig").TeltonikaData;
const imei_handler = @import("teltonika/imei_handler.zig").imei_handler;
const isValidChecksum = @import("teltonika/validate_checksum.zig").isValidChecksum;

pub const TcpServer = struct {
    address: std.net.Address,
    server: std.net.Server,
    allocator: std.mem.Allocator,
    thread_pool: *std.Thread.Pool,
    running: bool,

    pub fn init(allocator: std.mem.Allocator, ip: []const u8, port: u16) !TcpServer {
        const address = try std.net.Address.parseIp(ip, port);
        const server = try address.listen(.{ .reuse_address = true });

        const thread_pool = try allocator.create(std.Thread.Pool);
        try std.Thread.Pool.init(thread_pool, .{ .allocator = allocator });

        return TcpServer{
            .address = address,
            .server = server,
            .allocator = allocator,
            .thread_pool = thread_pool,
            .running = false,
        };
    }

    pub fn deinit(self: *TcpServer) void {
        self.running = false;
        self.thread_pool.deinit();
        self.server.deinit();
    }

    pub fn start(self: *TcpServer, comptime handler: fn (TeltonikaData, std.mem.Allocator) void) !void {
        self.running = true;
        try self.thread_pool.spawn(acceptConnections, .{ self, handler });
    }

    fn acceptConnections(self: *TcpServer, comptime handler: fn (TeltonikaData, std.mem.Allocator) void) void {
        while (self.running) {
            const conn = self.server.accept() catch |err| {
                if (comptime std.debug.runtime_safety) {
                    std.debug.print("Accept error: {}\n", .{err});
                }
                continue;
            };

            self.thread_pool.spawn(handleConnection, .{ self, conn, handler }) catch |err| {
                if (comptime std.debug.runtime_safety) {
                    std.debug.print("Failed to spawn thread: {}\n", .{err});
                }
                conn.stream.close();
            };
        }
    }

    fn handleConnection(self: *TcpServer, conn: std.net.Server.Connection, comptime handler: fn (TeltonikaData, std.mem.Allocator) void) void {
        defer conn.stream.close();

        var arena = std.heap.ArenaAllocator.init(self.allocator);
        defer arena.deinit();
        const conn_allocator = arena.allocator();

        if (comptime std.debug.runtime_safety) {
            std.debug.print("New connection from {}\n", .{conn.address});
        }

        var buffer: [1024]u8 = undefined;
        const bytes_read = conn.stream.read(&buffer) catch |err| {
            if (comptime std.debug.runtime_safety) {
                std.debug.print("Read error: {}\n", .{err});
            }
            return;
        };
        if (bytes_read == 0) return;

        const imei = imei_handler(buffer[0..bytes_read]);
        if (comptime std.debug.runtime_safety) {
            std.debug.print("Received IMEI: {}\n", .{imei});
        }

        const response = switch (imei) {
            0 => &[_]u8{0x00},
            else => &[_]u8{0x01},
        };
        conn.stream.writeAll(response) catch return;

        var packet_buffer: [2048]u8 = undefined;
        const packet_bytes_read = conn.stream.read(&packet_buffer) catch |err| {
            if (comptime std.debug.runtime_safety) {
                std.debug.print("Packet read error: {}\n", .{err});
            }
            return;
        };
        var packet_data = packet_buffer[0..packet_bytes_read];

        if (packet_data.len == 0) {
            if (comptime std.debug.runtime_safety) {
                std.debug.print("Received empty packet data. Ignoring...\n", .{});
            }
            return;
        }

        if (!isValidChecksum(packet_data)) {
            if (comptime std.debug.runtime_safety) {
                std.debug.print("Invalid checksum. Discarding packet.\n", .{});
            }
            return;
        }

        if (comptime std.debug.runtime_safety) {
            std.debug.print("Teltonika Packet (hex): ", .{});
            for (packet_data) |byte| {
                std.debug.print("{x:0>2} ", .{byte});
            }
            std.debug.print("\n", .{});
        }

        const teltonika_data = Parser.init(&packet_data, imei, conn_allocator) catch |err| {
            if (comptime std.debug.runtime_safety) {
                std.debug.print("Parser error: {}\n", .{err});
            }
            return;
        };
        handler(teltonika_data, conn_allocator);
    }
};

pub fn defaultHandler(teltonika_data: TeltonikaData, allocator: std.mem.Allocator) void {
    const json_string = std.json.stringifyAlloc(allocator, teltonika_data, .{ .emit_null_optional_fields = false }) catch |err| {
        std.log.err("Error stringifying JSON: {s}", .{@errorName(err)});
        return;
    };
    defer allocator.free(json_string);
    std.log.info("DATA: {s}\n\n", .{json_string});
}
