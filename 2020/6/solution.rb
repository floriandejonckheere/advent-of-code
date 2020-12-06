#!/usr/bin/env ruby

# frozen_string_literal: true

forms = File
  .read("./input.txt")
  .chomp("\n")
  .split("\n\n")

# Part one
puts forms.sum { |f| f.delete("\n").chars.uniq.count }

# Part two
puts forms.sum { |f| n = f.count("\n"); f.delete("\n").chars.tally.values.count { |v| v > n } }
