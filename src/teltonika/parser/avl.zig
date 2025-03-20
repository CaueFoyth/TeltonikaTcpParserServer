const std: type = @import("std");
const AvlData: type = @import("../../model/avl_data.zig").AvlData;
const IoElement: type = @import("../../model/io_element.zig").IoElement;
const IoElementParser = @import("./avl/io_elements/io_element.zig").IoElementParser;

pub const Avl = struct {
    pub const parseTimestamp = @import("./avl/timestamp.zig").parseTimestamp;
    pub const parsePriority = @import("./avl/priority.zig").parsePriority;
    pub const parseGpsElement = @import("./avl/gps_element.zig").parseGpsElement;

    pub fn init(data: *AvlData, packet_data: []u8, cursor: *usize, allocator: std.mem.Allocator) !void {
        if (packet_data.len < 1 or cursor.* >= packet_data.len) {
            return error.InvalidPacketData;
        }

        data.timestamp = try parseTimestamp(packet_data, cursor);
        data.priority = try parsePriority(packet_data, cursor);
        data.gps_element = try parseGpsElement(packet_data, cursor, allocator);

        data.io_elements = try IoElementParser.parseIoElements(packet_data, cursor, allocator);
    }
};
