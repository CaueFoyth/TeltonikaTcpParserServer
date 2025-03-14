const std = @import("std");

pub fn parseCodecId(packet_data: *[]u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;
    const codec_id = data[0];

    return codec_id;
}
