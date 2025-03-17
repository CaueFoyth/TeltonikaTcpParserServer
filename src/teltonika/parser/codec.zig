const std: type = @import("std");

pub fn parseCodecId(packet_data: *[]u8) !u8 {
    if (packet_data.*.len < 1) return error.InvalidData;

    const codec_id: u8 = packet_data.*[0];

    packet_data.* = packet_data.*[1..];

    return codec_id;
}
