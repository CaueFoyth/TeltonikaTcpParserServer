const GpsElement: type = @import("gps_element.zig").GpsElement;

pub const AvlData: type = struct {
    timestamp: ?u64,
    priority: ?u8,
    gps_element: GpsElement,

    pub fn init() AvlData {
        return AvlData{
            .timestamp = null,
            .priority = null,
            .gps_element = GpsElement.init(),
        };
    }
};
