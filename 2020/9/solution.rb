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
sum = sum(protocol[0..(size - 1)], protocol[size..])
puts sum

# Part two
def weakness(protocol, sum)
  protocol.each_with_index do |_, i|
    acc = []

    protocol[i..].each do |m|
      return acc.minmax.sum if acc.sum == sum
      next if acc.sum > sum

      acc << m
    end
  end
end

puts weakness(protocol, sum)
