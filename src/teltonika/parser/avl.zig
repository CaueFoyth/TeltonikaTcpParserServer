const std = @import("std");
const AvlData = @import("../../model/avl_data.zig").AvlData;

pub const Avl = struct {
    pub const parseTimestamp = @import("./avl/timestamp.zig").parseTimestamp;
    pub const parsePriority = @import("./avl/priority.zig").parsePriority;
    pub const parseGpsElement = @import("./avl/gps_element.zig").parseGpsElement;

    pub fn init(data: *AvlData, packet_data: []u8, cursor: *usize, allocator: std.mem.Allocator) !void {
        data.timestamp = try parseTimestamp(packet_data, cursor);
        data.priority = try parsePriority(packet_data, cursor);
        data.gps_element = try parseGpsElement(packet_data, cursor, allocator);
    }
};
