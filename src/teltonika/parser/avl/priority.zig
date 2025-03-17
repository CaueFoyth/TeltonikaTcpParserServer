const std: type = @import("std");

pub fn parsePriority(packet_data: *[]u8) !u8 {
    if (packet_data.*.len < 1) return error.InvalidData;
    const priority: u8 = packet_data.*[0];

    packet_data.* = packet_data.*[1..];

    return priority;
}
