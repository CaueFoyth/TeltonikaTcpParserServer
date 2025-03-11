const std = @import("std");

pub fn parseDataField(packet_data: *[]u8) !u32 {
    const data = packet_data.*;

    if (packet_data.len < 4) return error.InvalidData;

    const data_field = data[0..4];

    std.debug.print("Data Field (hex): ", .{});
    for (data_field) |byte| {
        std.debug.print("{x:0>2} ", .{byte});
    }
    std.debug.print("\n", .{});

    std.debug.print("Data Field (decimal): ", .{});
    for (data_field) |byte| {
        std.debug.print("{} ", .{byte});
    }
    std.debug.print("\n", .{});

    return (@as(u32, data_field[0]) << 24) |
        (@as(u32, data_field[1]) << 16) |
        (@as(u32, data_field[2]) << 8) |
        (@as(u32, data_field[3]));
}
