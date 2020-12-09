#!/usr/bin/env ruby

# frozen_string_literal: true

protocol = File
  .read("./input.txt")
  .split("\n")
  .map(&:to_i)

# Part one
def sum(buffer, protocol)
  protocol.each do |n|
    return n unless buffer.permutation(2).find { |(a, b)| a + b == n }

    buffer.push n
    buffer.shift
  end
end

size = 25
puts sum(protocol[0..(size - 1)], protocol[size..])
