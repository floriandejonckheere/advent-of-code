#!/usr/bin/env ruby

# frozen_string_literal: true

input = File
  .read("./input.txt")
  .split("\n\n")

fields = input
  .first
  .split("\n")
  .map do |line|
    _, field, r0, r1, s0, s1 = *line.match(/\A([a-z]*): ([0-9]*)-([0-9]*) or ([0-9]*)-([0-9]*)\z/)

    [field, [r0.to_i..r1.to_i, s0.to_i..s1.to_i]]
  end
    .to_h

my_ticket = input[1]
  .split("\n")
  .last
  .split(",")
  .map(&:to_i)

tickets = input
  .last
  .split("\n")[1..]
  .map { |l| l.split(",").map(&:to_i) }

# Part one
ranges = fields.values.flatten

puts tickets.flat_map { |t| t.select { |f| ranges.none? { |r| r === f } } }.sum
