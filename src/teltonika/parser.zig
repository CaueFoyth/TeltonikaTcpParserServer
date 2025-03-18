const std = @import("std");
const TeltonikaData = @import("../model/teltonika_data.zig").TeltonikaData;
const parsePreamble = @import("parser/preamble.zig").parsePreamble;
const parseDataField = @import("parser/data_field.zig").parseDataField;
const parseCodecId = @import("parser/codec.zig").parseCodecId;
const parseNumberData = @import("parser/number_data.zig").parseNumberData;
const parseCrc16 = @import("parser/crc16.zig").parseCrc16;
const Avl = @import("parser/avl.zig").Avl;

pub const Parser = struct {
    pub fn init(packet_data: *[]u8, imei: u64, allocator: std.mem.Allocator) !TeltonikaData {
        var data = TeltonikaData.init(imei);
        var cursor: usize = 0;

        data.preamble = try parsePreamble(packet_data.*, &cursor);
        data.data_size = try parseDataField(packet_data.*, &cursor);
        data.codec_id = try parseCodecId(packet_data.*, &cursor);
        data.number_data = try parseNumberData(packet_data.*, &cursor);
        try Avl.init(&data.avl_data, packet_data.*, &cursor, allocator);
        // data.crc16 = try parseCrc16(packet_data, &cursor);
        // data.number_data_2 = try parseNumberData(packet_data, &cursor, 2);

        packet_data.* = packet_data.*[cursor..];

        return data;
    }
};
