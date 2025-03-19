// Write fibonacci in ZIG
// Write a function that returns the nth fibonacci number

const std = @import("std");

pub fn fibonacci(n: u32) u32 {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

pub fn main() !void {
    const n = 10;
    const result = fibonacci(n);
    std.debug.print("Fibonacci of {} is {}\n", .{ n, result });
}
