#!/usr/bin/env ruby

# frozen_string_literal: true

passwords = File
  .read("./input.txt")
  .split("\n")
  .map { |l| /(\d+)-(\d+) ([a-z]): ([a-z]+)/.match(l).to_a }

# Part one
puts passwords.count { |(_, m, n, c, p)| (m.to_i..n.to_i) === p.chars.tally[c] }

# Part two
puts passwords.count { |(_, m, n, c, p)| (p[m.to_i - 1] == c) ^ (p[n.to_i - 1] == c) }
