const std = @import("std");

pub fn parseTimestamp(packet_data: []u8, cursor: *usize) !u64 {
    const start = cursor.*;
    if (start + 8 > packet_data.len) return error.InvalidData;

    const timestamp = (@as(u64, packet_data[start]) << 56) |
        (@as(u64, packet_data[start + 1]) << 48) |
        (@as(u64, packet_data[start + 2]) << 40) |
        (@as(u64, packet_data[start + 3]) << 32) |
        (@as(u64, packet_data[start + 4]) << 24) |
        (@as(u64, packet_data[start + 5]) << 16) |
        (@as(u64, packet_data[start + 6]) << 8) |
        (@as(u64, packet_data[start + 7]));
    cursor.* += 8;

    return timestamp;
}
