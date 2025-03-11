const std = @import("std");

pub fn parseNumberData(packet_data: *[]u8, number: u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;

    switch (number) {
        1 => {
            const number_data = data[0];
            std.debug.print("Case 1: Number of Data (hex): {x:0>2}\n", .{number_data});
            return number_data;
        },
        2 => {
            const number_data = data[data.len - 1];
            std.debug.print("Case 2: Number of Data (hex): {x:0>2}\n", .{number_data});
            return number_data;
        },
        else => {
            std.debug.print("Default Case: Number Invalid", .{});
            return 0;
        },
    }
}
