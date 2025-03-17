pub const GpsElement: type = struct {
    latitude: ?*[4]u8,
    longitude: ?*[4]u8,
    altitude: ?*[2]u8,
    angle: ?*[2]u8,
    satellites: ?*[1]u8,
    speed: ?*[2]u8,

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
