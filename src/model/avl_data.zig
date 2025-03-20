const GpsElement: type = @import("gps_element.zig").GpsElement;
const IoElement: type = @import("io_element.zig").IoElement;

pub const AvlData: type = struct {
    timestamp: ?u64,
    priority: ?u8,
    gps_element: GpsElement,
    io_elements: []IoElement,

    pub fn init() AvlData {
        return AvlData{
            .timestamp = null,
            .priority = null,
            .gps_element = GpsElement.init(),
            .io_elements = &[_]IoElement{},
        };
    }
};
