const std: type = @import("std");

pub fn parseNumberData(packet_data: *[]u8, number: u8) !u8 {
    if (packet_data.*.len < 1) return error.InvalidData;

    switch (number) {
        1 => {
            const number_data: u8 = packet_data.*[0];
            packet_data.* = packet_data.*[1..];
            return number_data;
        },
        2 => {
            const number_data: u8 = packet_data.*[packet_data.*.len - 1];
            packet_data.* = packet_data.*[0 .. packet_data.*.len - 1];
            return number_data;
        },
        else => {
            std.debug.print("Default Case: Number Invalid", .{});
            return 0;
        },
    }
}
