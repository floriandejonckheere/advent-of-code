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

# Part two
def floatmask(mask, bits)
  ones = mask.tr("X", "0").to_i(2)
  bits |= ones

  # Find indices of Xs
  exes = mask.chars.reverse.filter_map.with_index { |x, i| i if x == "X" }

  # Zero out Xs
  bits &= ~exes.map { |b| 1 << b }.reduce(&:|)

  (0..exes.length).flat_map do |length|
    exes
      .combination(length)                                 # Make all possible combination of indices of Xs
      .filter_map { |i| i.map { |b| 1 << b }.reduce(&:|) } # Turn them into bitmaps
      .prepend(0)                                          # Add zero bitmap
      .map { |m| bits | m }                                # Apply bitmap
  end
end

mask = nil
mem = Hash.new(0)

input.each do |i|
  # Parse mask
  next mask = i.split(" ").last if i.start_with? "mask"

  # Parse address and value
  adr, bits = *i.match(/\Amem\[([0-9]*)\] = ([0-9]*)\z/).to_a[1..]

  # Generate floating addresses
  floatmask(mask, adr.to_i).each { |a| mem[a] = bits.to_i }
end

puts mem.values.sum
