#!/usr/bin/env ruby

# frozen_string_literal: true

grid = File
  .read("./input.txt")
  .split("\n")
  .map { |l| l.split("") }

# Part one
puts grid.filter_map.with_index { |x, i| x[(3 * i) % x.count] == "#" }.count
