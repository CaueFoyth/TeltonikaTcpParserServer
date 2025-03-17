const std: type = @import("std");

pub fn parseCrc16(packet_data: *[]u8) !u32 {
    if (packet_data.*.len <= 4) return error.InvalidData;

    const last_4_bytes: []u8 = packet_data.*[packet_data.*.len - 4 ..];

    packet_data.* = packet_data.*[0 .. packet_data.len - 2];

    return (@as(u32, last_4_bytes[0]) << 24) |
        (@as(u32, last_4_bytes[1]) << 16) |
        (@as(u32, last_4_bytes[2]) << 8) |
        (@as(u32, last_4_bytes[3]));
}
