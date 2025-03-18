pub const GpsElement: type = struct {
    latitude: ?[]const u8,
    longitude: ?[]const u8,
    altitude: ?i16,
    angle: ?u16,
    satellites: ?u8,
    speed: ?u16,

    pub fn init() GpsElement {
        return GpsElement{
            .latitude = null,
            .longitude = null,
            .altitude = null,
            .angle = null,
            .satellites = null,
            .speed = null,
        };
    }
};
