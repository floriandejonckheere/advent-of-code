#!/usr/bin/env ruby

# frozen_string_literal: true

passports = File
  .read("./input.txt")
  .split("\n\n")
  .map { |l| l.split(/[\n: ]/).each_slice(2).to_h }

# Part one
r = %w(byr iyr eyr hgt hcl ecl pid).freeze

puts passports.count { |p| (r & p.keys) == r }

# Part two
c = %w(amb blu brn gry grn hzl oth).freeze
r = {
  "byr" => -> (y) { (1920..2002) === y.to_i },
  "iyr" => -> (y) { (2010..2020) === y.to_i },
  "eyr" => -> (y) { (2020..2030) === y.to_i },
  "hgt" =>-> (h) { q, i, j = *(/\A([0-9]+)(in|cm)\z/.match h); q && j == "cm" ? ((150..193) === i.to_i) : ((59..76) === i.to_i) },
  "hcl" => -> (h) { /\A#[0-9a-f]{6}\z/.match? h },
  "ecl" => -> (e) { c.include? e },
  "pid" => -> (p) { /\A[0-9]{9}\z/.match? p},
}.freeze

puts passports.count { |p| ((r.keys & p.keys) == r.keys) && r.all? { |k, v| p[k] && v.call(p[k]) } }
