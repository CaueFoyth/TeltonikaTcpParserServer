const AvlData: type = @import("avl_data.zig").AvlData;

pub const TeltonikaData: type = struct {
    imei: u64,
    preamble: ?u32,
    data_size: ?u32,
    codec_id: ?u8,
    number_data: ?u8,
    avl_data_list: ?[]AvlData,
    number_data_2: ?u8,
    crc16: ?u32,

    pub fn init(imei: u64) TeltonikaData {
        return TeltonikaData{
            .imei = imei,
            .preamble = null,
            .data_size = null,
            .codec_id = null,
            .number_data = null,
            .avl_data_list = null,
            .number_data_2 = null,
            .crc16 = null,
        };
    }
};
