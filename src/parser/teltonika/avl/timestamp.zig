const std = @import("std");

pub fn parseTimestamp(packet_data: *[]u8) !u64 {
    const data = packet_data.*;

    if (data.len <= 8) return error.InvalidData;
    const timestamp_bytes = data[0..8];

    return (@as(u64, timestamp_bytes[0]) << 56) |
        (@as(u64, timestamp_bytes[1]) << 48) |
        (@as(u64, timestamp_bytes[2]) << 40) |
        (@as(u64, timestamp_bytes[3]) << 32) |
        (@as(u64, timestamp_bytes[4]) << 24) |
        (@as(u64, timestamp_bytes[5]) << 16) |
        (@as(u64, timestamp_bytes[6]) << 8) |
        (@as(u64, timestamp_bytes[7]));
}
