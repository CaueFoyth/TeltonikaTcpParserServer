pub const IoElement: type = struct {
    id: ?u64,
    property: ?[]const u8,
    value: ?u64,
    hex_value: ?[]const u8,

    pub fn init() !IoElement {
        return IoElement{
            .id = null,
            .property = null,
            .value = null,
            .hex_value = null,
        };
    }
};
