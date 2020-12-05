#!/usr/bin/env ruby

# frozen_string_literal: true

seats = File
  .read("./input.txt")
  .split("\n")

ids = seats.map { |s| (s[0..6].tr("FB", "01").to_i(2) * 8) + s[7..9].tr("LR", "01").to_i(2) }

# Part one
puts ids.max

# Part two
puts (ids.min..ids.max).to_a - ids
