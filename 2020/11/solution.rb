#!/usr/bin/env ruby

# frozen_string_literal: true

require "byebug"

seats = File
  .read("./input.txt")
  .split("\n")
  .map { |l| l.split("") }

# Part one
def adjacent(seats, i, j)
  seats[[0, i-1].max..[i+1, seats.length].min]
    .flat_map { |r| r[[0, j-1].max..[j+1, seats[0].length].min] }
    .tap { |a| a.delete_at(a.index(seats[i][j])) }
    .count { |s| s == "#" }
end

def mutate(seats)
  seats.map(&:dup).each_with_index do |r, i|
    r.each_with_index do |c, j|
      r[j] = "#" if c == "L" && adjacent(seats, i, j) == 0
      r[j] = "L" if c == "#" && adjacent(seats, i, j) >= 4
    end
  end
end

i = 0
prev = seats

loop do
  i += 1

  new = mutate(prev)

  break if new.flatten == prev.flatten

  prev = new
end

puts prev.flatten.count { |c| c == "#" }
