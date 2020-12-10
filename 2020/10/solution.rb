#!/usr/bin/env ruby

# frozen_string_literal: true

adapters = File
  .read("./input.txt")
  .split("\n")
  .map(&:to_i)

adapters = [0, *adapters.sort, adapters.max + 3]

# Part one
puts adapters
  .each_cons(2)
  .map { |a, b| b - a }
  .tally
  .values
  .reduce(:*)

# Part two
def traverse(adapters, results = {})
  current = adapters.shift

  return 1 if adapters.empty?

  adapters
    .filter_map
    .with_index { |a, i| i unless a > current + 3 }
    .map { |i| results[adapters[i]] ||= traverse(adapters[i..], results) }
    .sum
end

puts traverse(adapters)
