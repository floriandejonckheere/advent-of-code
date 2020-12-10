#!/usr/bin/env ruby

# frozen_string_literal: true

adapters = File
  .read("./input.txt")
  .split("\n")
  .map(&:to_i)

# Part one
adapters = [0, *adapters.sort, adapters.max + 3]

puts adapters
  .each_cons(2)
  .map { |a, b| b - a }
  .tally
  .values
  .reduce(:*)
