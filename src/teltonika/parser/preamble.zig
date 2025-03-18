const std = @import("std");

pub fn parsePreamble(packet_data: []u8, cursor: *usize) !u32 {
    const start = cursor.*;
    if (start + 4 > packet_data.len) return error.InvalidData;

    const preamble = (@as(u32, packet_data[start]) << 24) |
        (@as(u32, packet_data[start + 1]) << 16) |
        (@as(u32, packet_data[start + 2]) << 8) |
        (@as(u32, packet_data[start + 3]));
    cursor.* += 4;

    return preamble;
}
