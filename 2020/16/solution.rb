#!/usr/bin/env ruby

# frozen_string_literal: true

require "byebug"

input = File
  .read("./input.txt")
  .split("\n\n")

fields = input
  .first
  .split("\n")
  .map do |line|
    _, field, r0, r1, s0, s1 = *line.match(/\A([a-z ]*): ([0-9]*)-([0-9]*) or ([0-9]*)-([0-9]*)\z/)

    [field, [r0.to_i..r1.to_i, s0.to_i..s1.to_i]]
  end
    .to_h

my_ticket = input[1]
  .split("\n")
  .last
  .split(",")
  .map(&:to_i)

tickets = input
  .last
  .split("\n")[1..]
  .map { |l| l.split(",").map(&:to_i) }

# Part one
ranges = fields.values.flatten

puts tickets.flat_map { |t| t.select { |f| ranges.none? { |r| r === f } } }.sum

# Part two
valid = tickets.select { |t| t.all? { |f| ranges.any? { |r| r === f } } }

candidates = Hash.new(fields.keys)

valid.each do |ticket|
  ticket.each_with_index do |field, i|
    ticket_candidates = fields.filter_map { |candidate, ranges| candidate if ranges.any? { |r| r === field } }

    candidates[i] &= ticket_candidates
  end
end

mapping = {}

loop do
  index, values = candidates.find { |(i, values)| values.count == 1 }

  break unless index

  value = values.first
  mapping[index] = value

  candidates.transform_values! { |values| values - [value] }
end

puts mapping
.select { |_, field| field =~ /\Adeparture/ }
.keys
.map { |i| my_ticket[i] }
.reduce(&:*)
