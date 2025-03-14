const std = @import("std");

pub fn parseNumberData(packet_data: *[]u8, number: u8) !u8 {
    const data = packet_data.*;

    if (data.len < 1) return error.InvalidData;

    switch (number) {
        1 => {
            const number_data = data[0];
            return number_data;
        },
        2 => {
            const number_data = data[data.len - 1];
            return number_data;
        },
        else => {
            std.debug.print("Default Case: Number Invalid", .{});
            return 0;
        },
    }
}
