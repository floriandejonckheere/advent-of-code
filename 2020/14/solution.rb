#!/usr/bin/env ruby

# frozen_string_literal: true

input = File
  .read("./input.txt")
  .split("\n")

# Part one
def bitmask(mask, bits)
  ones = mask.tr("X", "0").to_i(2)
  zeros = mask.tr("X", "1").to_i(2)

  (bits | ones) & zeros
end

mask = nil
mem = Hash.new(0)

input.each do |i|
  next mask = i.split(" ").last if i.start_with? "mask"

  adr, bits = *i.match(/\Amem\[([0-9]*)\] = ([0-9]*)\z/).to_a[1..]
  mem[adr.to_i] = bitmask(mask, bits.to_i)
end

puts mem.values.sum
