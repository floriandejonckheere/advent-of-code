#!/usr/bin/env ruby

# frozen_string_literal: true

input = File
  .read("./input.txt")
  .split("\n")
timestamp = input[0].to_i
schedules = input[1]
  .split(",")
  .reject { |s| s == "x"}
  .map(&:to_i)

# Part one
bus = schedules
   .map { |s| [s, s * (0..).find { |i| i * s > timestamp }] }
   .min { |a, b| a.last <=> b.last }

puts bus[0] * (bus[1] - timestamp)
