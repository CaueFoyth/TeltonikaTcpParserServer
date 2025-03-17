pub fn isValidChecksum(packet_data: []const u8) bool {
    if (packet_data.len < 4) return false;
    const length: u8 = packet_data[1];
    const data_start: comptime_int = 2;
    const data_end = 2 + length;
    const crc_start = data_end;
    const crc_end = data_end + 2;
    if (packet_data.len < crc_end + 1) return false;
    const data_to_check: []const u8 = packet_data[data_start..data_end];
    const provided_crc_bytes: []const u8 = packet_data[crc_start..crc_end];
    const calculated_crc: u16 = crc16(data_to_check);
    const provided_crc = @as(u16, provided_crc_bytes[0]) << 8 | provided_crc_bytes[1];
    return calculated_crc == provided_crc;
}

fn crc16(data: []const u8) u16 {
    const polynomial: u16 = 0x1021;
    var crc: u16 = 0;
    for (data) |byte| {
        crc ^= @as(u16, byte) << 8;
        for (0..8) |_| {
            if ((crc & 0x8000) != 0) {
                crc = (crc << 1) ^ polynomial;
            } else {
                crc <<= 1;
            }
            crc &= 0xFFFF;
        }
    }
    return crc;
}
