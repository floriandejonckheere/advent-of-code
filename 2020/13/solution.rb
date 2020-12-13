#!/usr/bin/env ruby

# frozen_string_literal: true

input = File
  .read("./input.txt")
  .split("\n")

# Part one
timestamp = input.first.to_i
schedules = input
  .last
  .split(",")
  .reject { |s| s == "x"}
  .map(&:to_i)

bus = schedules
   .map { |s| [s, s * (0..).find { |t| t * s > timestamp }] }
   .min_by(&:last)

puts bus[0] * (bus[1] - timestamp)

# Part two
# https://github.com/acmeism/RosettaCodeData/blob/master/Task/Chinese-remainder-theorem/Ruby/chinese-remainder-theorem-2.rb
def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject( :* )  # product of all moduli
  series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
  series.inject( :+ ) % max
end

schedules = input
  .last
  .split(",")
  .filter_map
  .with_index { |s, i| [s.to_i, (s.to_i - i)] unless s == "x" }
  .to_h

puts chinese_remainder(schedules.keys, schedules.values)
