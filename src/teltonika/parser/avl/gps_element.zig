const std = @import("std");
const GpsElement = @import("../../../model/gps_element.zig").GpsElement;

pub fn parseGpsElement(packet_data: []u8, cursor: *usize, allocator: std.mem.Allocator) !GpsElement {
    const start = cursor.*;
    if (start + 15 > packet_data.len) return error.InvalidData;

    var gps_element = GpsElement.init();

    const longitude_buf: [4]u8 = packet_data[start .. start + 4][0..4].*;
    const longitude_raw = std.mem.readInt(i32, &longitude_buf, .big);
    const longitude_value = @as(f64, @floatFromInt(longitude_raw)) / 10_000_000.0;
    gps_element.longitude = try std.fmt.allocPrint(allocator, "{d:.7}", .{longitude_value});

    const latitude_buf: [4]u8 = packet_data[start + 4 .. start + 8][0..4].*;
    const latitude_raw = std.mem.readInt(i32, &latitude_buf, .big);
    const latitude_value = @as(f64, @floatFromInt(latitude_raw)) / 10_000_000.0;
    gps_element.latitude = try std.fmt.allocPrint(allocator, "{d:.7}", .{latitude_value});

    const altitude_buf: [2]u8 = packet_data[start + 8 .. start + 10][0..2].*;
    const altitude_raw = std.mem.readInt(i16, &altitude_buf, .big);
    gps_element.altitude = altitude_raw;

    const angle_buf: [2]u8 = packet_data[start + 10 .. start + 12][0..2].*;
    const angle_raw = std.mem.readInt(u16, &angle_buf, .big);
    gps_element.angle = angle_raw;

    gps_element.satellites = packet_data[start + 12];

    const speed_buf: [2]u8 = packet_data[start + 13 .. start + 15][0..2].*;
    const speed_raw = std.mem.readInt(u16, &speed_buf, .big);
    gps_element.speed = speed_raw;

    cursor.* += 15;

    return gps_element;
}
