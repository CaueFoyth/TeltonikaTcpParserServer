const std = @import("std");

pub fn parsePreamble(packet_data: *[]u8) !u32 {
    const data = packet_data.*;

    if (data.len < 4) return error.InvalidData;

    const preamble = data[0..4];

    std.debug.print("Preamble (hex): ", .{});
    for (preamble) |byte| {
        std.debug.print("{x:0>2} ", .{byte});
    }
    std.debug.print("\n", .{});

    return (@as(u32, preamble[0]) << 24) |
        (@as(u32, preamble[1]) << 16) |
        (@as(u32, preamble[2]) << 8) |
        (@as(u32, preamble[3]));
}
