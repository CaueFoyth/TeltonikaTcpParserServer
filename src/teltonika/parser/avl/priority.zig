const std = @import("std");

pub fn parsePriority(packet_data: []u8, cursor: *usize) !u8 {
    const start = cursor.*;
    if (start + 1 > packet_data.len) return error.InvalidData;

    const priority = packet_data[start];
    cursor.* += 1;

    return priority;
}
