const std = @import("std");

pub fn parseCodecId(packet_data: []u8, cursor: *usize) !u8 {
    const start = cursor.*;
    if (start + 1 > packet_data.len) return error.InvalidData;

    const codec_id = packet_data[start];
    cursor.* += 1;

    return codec_id;
}
