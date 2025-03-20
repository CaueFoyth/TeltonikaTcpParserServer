const std = @import("std");
const IoElement: type = @import("../../../../model/io_element.zig").IoElement;

pub const IoElementParser = struct {
    pub fn parseIoElements(packet_data: []u8, cursor: *usize, allocator: std.mem.Allocator) ![]IoElement {
        if (cursor.* + 2 > packet_data.len) {
            return error.InvalidPacketData;
        }
        const event_io_id: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
        cursor.* += 2;

        _ = event_io_id;

        if (cursor.* + 2 > packet_data.len) {
            return error.InvalidPacketData;
        }
        const total_io_elements: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
        cursor.* += 2;

        var io_elements_array = try allocator.alloc(IoElement, total_io_elements);
        var index: usize = 0;

        const event_sizes = [_]u8{ 1, 2, 4, 8 };

        for (event_sizes) |size| {
            if (cursor.* + 2 > packet_data.len) {
                return error.InvalidPacketData;
            }

            const event_count: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
            cursor.* += 2;

            for (0..event_count) |_| {
                if (index >= total_io_elements) break;

                if (cursor.* + size + 2 > packet_data.len) {
                    return error.InvalidPacketData;
                }

                const event_id: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
                cursor.* += 2;

                var event_value: u64 = 0;
                for (0..size) |i| {
                    event_value |= (@as(u64, packet_data[cursor.* + i]) << @intCast(i * 8));
                }
                cursor.* += size;

                var io_element_instance = try IoElement.init();
                io_element_instance.id = event_id;
                io_element_instance.property = "io_element";
                io_element_instance.value = event_value;
                io_element_instance.formated_value = "Teste";
                io_elements_array[index] = io_element_instance;
                index += 1;
            }
        }

        if (cursor.* + 2 > packet_data.len) {
            return error.InvalidPacketData;
        }
        const event_count_xb: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
        cursor.* += 2;

        for (0..event_count_xb) |_| {
            if (index >= total_io_elements) break;

            if (cursor.* + 4 > packet_data.len) {
                return error.InvalidPacketData;
            }

            const event_id: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
            cursor.* += 2;

            const event_value_size: u16 = (@as(u16, packet_data[cursor.*]) << 8) | (@as(u16, packet_data[cursor.* + 1]));
            cursor.* += 2;

            if (cursor.* + event_value_size > packet_data.len) {
                return error.InvalidPacketData;
            }

            const event_value = try allocator.alloc(u8, event_value_size);
            @memcpy(event_value, packet_data[cursor.* .. cursor.* + event_value_size]);
            cursor.* += event_value_size;

            var io_element_instance = try IoElement.init();
            io_element_instance.id = event_id;
            io_element_instance.property = "io_element";

            if (event_value_size <= @sizeOf(u64)) {
                var temp_value: u64 = 0;
                for (0..event_value_size) |i| {
                    temp_value |= (@as(u64, packet_data[cursor.* - event_value_size + i]) << @intCast(i * 8));
                }
                io_element_instance.value = temp_value;
            } else {
                io_element_instance.value = null;
            }
            io_element_instance.formated_value = "Teste";

            io_elements_array[index] = io_element_instance;
            index += 1;
        }

        return io_elements_array[0..index];
    }
};
