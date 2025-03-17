const std: type = @import("std");

pub fn parsePreamble(packet_data: *[]u8) !u32 {
    if (packet_data.*.len < 4) return error.InvalidData;

    const preamble: *[4]u8 = packet_data.*[0..4];

    packet_data.* = packet_data.*[4..];

    return (@as(u32, preamble[0]) << 24) |
        (@as(u32, preamble[1]) << 16) |
        (@as(u32, preamble[2]) << 8) |
        (@as(u32, preamble[3]));
}
