const std = @import("std");
const TeltonikaData = @import("../model/teltonika_data.zig").TeltonikaData;
const parsePreamble = @import("teltonika/preamble.zig").parsePreamble;
const parseDataField = @import("teltonika/data_field.zig").parseDataField;
const parseCodecId = @import("teltonika/codec.zig").parseCodecId;
const parseNumberData = @import("teltonika/number_data.zig").parseNumberData;
const parseCrc16 = @import("teltonika/crc16.zig").parseCrc16;

pub const Parser = struct {
    pub fn init(packet_data: *[]u8, imei: u64) !TeltonikaData {
        var data = TeltonikaData.init(0);
        data.imei = imei;

        data.preamble = try parsePreamble(packet_data);
        packet_data.* = packet_data.*[4..];

        data.data_size = try parseDataField(packet_data);
        packet_data.* = packet_data.*[4..];

        // data.codec_id = parseCodecId(packet_data);
        // packet_data.* = packet_data.*[1..];

        // data.number_data = parseNumberData(remaining_data);
        // remaining_data = remaining_data[1..];

        return data;
    }
};
