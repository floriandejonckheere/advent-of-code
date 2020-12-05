#!/usr/bin/env ruby

# frozen_string_literal: true

seats = File
  .read("./input.txt")
  .split("\n")

def decode(seat)
  x = seat[0..6].tr("FB", "01").to_i(2)
  y = seat[7..9].tr("LR", "01").to_i(2)

  (x * 8) + y
end

# Part one
puts seats.map { |s| decode s }.max

