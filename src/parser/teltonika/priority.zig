const std = @import("std");

pub fn parsePriority(packet_data: *[]u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;
    const priority = data[0];

    std.debug.print("Priority (hex): {x:0>2}", .{priority});
    std.debug.print("\n", .{});
    std.debug.print("Priority (decimal): {}\n", .{priority});

    return priority;
}
