#!/usr/bin/env ruby

# frozen_string_literal: true

numbers = File
  .read("./input.txt")
  .split("\n")
  .map(&:to_i)

a, b = numbers
  .permutation(2)
  .find { |a, b| a + b == 2020 }

puts "#{a} * #{b} = #{a * b}"
