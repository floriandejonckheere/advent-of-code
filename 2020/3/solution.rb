#!/usr/bin/env ruby

# frozen_string_literal: true

grid = File
  .read("./input.txt")
  .split("\n")
  .map { |l| l.split("") }

def trees(grid, x = 3, y = 1)
  grid
    .each_slice(y)
    .filter_map
    .with_index { |i, j| i.first[(x * j) % i.first.count] == "#" }
    .count
end

# Part one
puts trees(grid, 3, 1)

# Part two
puts [[1, 1], [1, 3], [5, 1], [7, 1], [1, 2]]
  .map { |(x, y)| trees(grid, x, y) }
  .reduce(:*)
