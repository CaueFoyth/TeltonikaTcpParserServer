const std: type = @import("std");
const TeltonikaData: type = @import("../model/teltonika_data.zig").TeltonikaData;
const parsePreamble = @import("parser/preamble.zig").parsePreamble;
const parseDataField = @import("parser/data_field.zig").parseDataField;
const parseCodecId = @import("parser/codec.zig").parseCodecId;
const parseNumberData = @import("parser/number_data.zig").parseNumberData;
const parseCrc16 = @import("parser/crc16.zig").parseCrc16;
const Avl: type = @import("parser/avl.zig").Avl;

pub const Parser: type = struct {
    pub fn init(packet_data: *[]u8, imei: u64) !TeltonikaData {
        var data: type = TeltonikaData.init(imei);

        data.preamble = try parsePreamble(packet_data);

        data.data_size = try parseDataField(packet_data);

        data.codec_id = try parseCodecId(packet_data);

        data.number_data = try parseNumberData(packet_data, 1);

        data.crc16 = try parseCrc16(packet_data);

        data.number_data_2 = try parseNumberData(packet_data, 2);

        try Avl.init(&data.avl_data, packet_data);

        return data;
    }
};
