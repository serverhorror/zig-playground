const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // try stdout_file.print("A message to stdout file\n", .{});

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "always succeeds" {
    try expect(true);
}

test "assignment stuff" {
    const constant: i32 = 5;
    _ = constant;

    var variable: u32 = 5000;
    _ = variable;

    // @as performs an explicit type coercion
    const inferred_constant = @as(i32, 5);
    _ = inferred_constant;
    var inferred_variable = @as(u32, 5000);
    _ = inferred_variable;
}
