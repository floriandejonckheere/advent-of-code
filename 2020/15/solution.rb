#!/usr/bin/env ruby

# frozen_string_literal: true

require "byebug"

# Part one
def speak(numbers, turns)
  (numbers.length..(turns - 1)).each do |i|
    n = numbers.pop
    m = numbers.rindex(n)
    m = m.nil? ? 0 : i - (m + 1)

    numbers << n
    numbers << m
  end

  numbers.last
end

puts speak([0, 3, 6], 2020) # => 436
puts speak([1, 3, 2], 2020) # => 1
puts speak([2, 1, 3], 2020) # => 10
puts speak([1, 2, 3], 2020) # => 27
puts speak([2, 3, 1], 2020) # => 78
puts speak([3, 2, 1], 2020) # => 438
puts speak([3, 1, 2], 2020) # => 1836

puts speak([0, 5, 4, 1, 10, 14, 7], 2020) # => 203
