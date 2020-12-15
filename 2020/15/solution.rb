#!/usr/bin/env ruby

# frozen_string_literal: true

def speak(numbers, turns)
  tally = Hash[numbers[0..-2].map.with_index { |n, i| [n, i + 1] }]

  (numbers.length..(turns - 1)).each do |i|
    prev = tally[numbers.last]
    prev = prev.nil? ? 0 : i - prev

    tally[numbers.last] = i
    numbers << prev
  end

  numbers.last
end

# Part one
# puts speak([0, 3, 6], 10) # => 436
puts speak([0, 3, 6], 2020) # => 436
puts speak([1, 3, 2], 2020) # => 1
puts speak([2, 1, 3], 2020) # => 10
puts speak([1, 2, 3], 2020) # => 27
puts speak([2, 3, 1], 2020) # => 78
puts speak([3, 2, 1], 2020) # => 438
puts speak([3, 1, 2], 2020) # => 1836

puts speak([0, 5, 4, 1, 10, 14, 7], 2020) # => 203

# Part two
puts speak([0, 3, 6], 30_000_000) # => 175594
puts speak([1, 3, 2], 30_000_000) # => 2578
puts speak([2, 1, 3], 30_000_000) # => 3544142
puts speak([1, 2, 3], 30_000_000) # => 261214
puts speak([2, 3, 1], 30_000_000) # => 6895259
puts speak([3, 2, 1], 30_000_000) # => 18
puts speak([3, 1, 2], 30_000_000) # => 362

puts speak([0, 5, 4, 1, 10, 14, 7], 30_000_000) # => 9007186
