const std = @import("std");

pub fn parsePriority(packet_data: *[]u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;
    const priority = data[0];

    return priority;
}
