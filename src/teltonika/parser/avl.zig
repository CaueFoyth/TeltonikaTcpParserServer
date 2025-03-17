const AvlData: type = @import("../../model/avl_data.zig").AvlData;

pub const Avl: type = struct {
    pub const parseTimestamp = @import("./avl/timestamp.zig").parseTimestamp;
    pub const parsePriority = @import("./avl/priority.zig").parsePriority;
    pub const parseGpsElement = @import("./avl/gps_element.zig").parseGpsElement;

    pub fn init(data: *AvlData, packet_data: *[]u8) !void {
        data.timestamp = try parseTimestamp(packet_data);

        data.priority = try parsePriority(packet_data);

        data.gps_element = try parseGpsElement(packet_data);
    }
};
