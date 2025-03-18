const std = @import("std");

pub fn isValidChecksum(buffer: []u8) bool {
    if (buffer.len < 8) {
        std.log.info("Buffer too short: {} < 8", .{buffer.len});
        return false;
    }
    const avlDataLength = std.mem.readInt(u32, buffer[4..8], .big);
    const packetLength = 8 + avlDataLength + 4;
    if (buffer.len > packetLength) {
        std.log.info("Too much data received. Expected {}, received {}", .{ packetLength, buffer.len });
        return false;
    }
    return true;
}
