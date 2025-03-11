const std = @import("std");

pub fn parseCodecId(packet_data: *[]u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;
    const codec_id = data[0];

    std.debug.print("ID do codec (hex): {x:0>2}", .{codec_id});
    std.debug.print("\n", .{});
    std.debug.print("ID do codec (decimal): {}\n", .{codec_id});

    return codec_id;
}
