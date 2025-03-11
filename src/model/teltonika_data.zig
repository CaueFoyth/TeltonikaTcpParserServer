pub const TeltonikaData = struct {
    imei: u64,
    preamble: u32,
    data_size: u32,
    codec_id: u8,
    number_data: u8,
    crc16: u32,
    number_data_2: u8,
    timestamp: u64,
    priority: u8,

    pub fn init(imei: u64) TeltonikaData {
        return TeltonikaData{
            .imei = imei,
            .preamble = 0,
            .data_size = 0,
            .codec_id = 0,
            .number_data = 0,
            .crc16 = 0,
            .number_data_2 = 0,
            .timestamp = 0,
            .priority = 0,
        };
    }
};
