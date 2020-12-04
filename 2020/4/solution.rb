#!/usr/bin/env ruby

# frozen_string_literal: true

passports = File
  .read("./input.txt")
  .split("\n\n")
  .map { |l| l.split(/[\n: ]/).each_slice(2).map(&:first) }

# Part one
r = %w(byr iyr eyr hgt hcl ecl pid).freeze

puts passports.count { |p| (r & p) == r }
