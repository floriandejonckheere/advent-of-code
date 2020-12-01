#!/usr/bin/env ruby

# frozen_string_literal: true

numbers = File
  .read("./input.txt")
  .split("\n")
  .map(&:to_i)

# Part one
a, b = numbers.permutation(2).find { |a, b| a + b == 2020 }

puts "#{a} * #{b} = #{a * b}"

# Part two
a, b, c = numbers.permutation(3).find { |a, b, c| a + b + c == 2020 }

puts "#{a} * #{b} * #{c} = #{a * b * c}"
