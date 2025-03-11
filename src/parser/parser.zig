const std = @import("std");

pub const Parser = struct {
    const testing = std.testing;
    pub const imei_handler = @import("teltonika/imei_handler.zig").imei_handler;
    pub const TeltonikaData = @import("../model/teltonika_data.zig").TeltonikaData;
    pub const parsePreamble = @import("teltonika/preamble.zig").parsePreamble;
    pub const parseDataField = @import("teltonika/data_field.zig").parseDataField;
    pub const parseCodecId = @import("teltonika/codec.zig").parseCodecId;
    pub const parseNumberData = @import("teltonika/number_data.zig").parseNumberData;
    pub const parseCrc16 = @import("teltonika/crc16.zig").parseCrc16;
    pub const parseTimestamp = @import("teltonika/timestamp.zig").parseTimestamp;
    pub const parsePriority = @import("teltonika/priority.zig").parsePriority;
};
