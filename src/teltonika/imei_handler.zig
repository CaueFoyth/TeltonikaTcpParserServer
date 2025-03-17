const std: type = @import("std");

pub fn imei_handler(packet: []const u8) u64 {
    const expected_prefix: [2]u8 = [2]u8{ 0x00, 0x0f };
    if (packet.len < 2 or !std.mem.eql(u8, packet[0..2], &expected_prefix)) return 0;

    const imei_length: u16 = readInt(u16, packet[0..2], .big) catch return 0;
    if (imei_length == 0 or packet.len < 2 + imei_length) return 0;
    const imei: []const u8 = packet[2 .. 2 + imei_length];

    const parse_result: u64 = parseInt(u64, imei, 10) catch return 0;
    return parse_result;
}

fn readInt(comptime T: type, bytes: []const u8, endian: std.builtin.Endian) !T {
    const buffer: *const [2]u8 = bytes[0..2];
    return std.mem.readInt(T, buffer, endian);
}

fn parseInt(comptime T: type, bytes: []const u8, radix: u8) !T {
    return std.fmt.parseInt(T, bytes, radix);
}
