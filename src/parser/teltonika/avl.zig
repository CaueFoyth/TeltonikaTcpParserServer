pub const Avl = struct {
    pub const parseTimestamp = @import("teltonika/avl/timestamp.zig").parseTimestamp;
    pub const parsePriority = @import("teltonika/avl/priority.zig").parsePriority;
};
