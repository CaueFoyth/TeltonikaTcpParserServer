const std: type = @import("std");
const GpsElement: type = @import("../../../model/gps_element.zig").GpsElement;

pub fn parseGpsElement(packet_data: *[]u8) !GpsElement {
    if (packet_data.*.len < 1) return error.InvalidData;
    var gps_element: type = GpsElement.init();

    gps_element.longitude = packet_data.*[0..4];
    gps_element.latitude = packet_data.*[4..8];
    gps_element.altitude = packet_data.*[8..10];
    gps_element.angle = packet_data.*[10..12];
    gps_element.satellites = packet_data.*[12..13];
    gps_element.speed = packet_data.*[13..15];

    packet_data.* = packet_data.*[15..];

    return gps_element;
}
