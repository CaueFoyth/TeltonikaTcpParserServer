const std = @import("std");

pub fn parseCrc16(packet_data: *[]u8) !u32 {
    const data = packet_data.*;

    if (data.len <= 4) return error.InvalidData;
    const last_4_bytes = data[data.len - 4 ..];

    return (@as(u32, last_4_bytes[0]) << 24) |
        (@as(u32, last_4_bytes[1]) << 16) |
        (@as(u32, last_4_bytes[2]) << 8) |
        (@as(u32, last_4_bytes[3]));
}
