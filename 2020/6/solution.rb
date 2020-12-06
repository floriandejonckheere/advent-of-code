#!/usr/bin/env ruby

# frozen_string_literal: true

forms = File
  .read("./input.txt")
  .split("\n\n")

# Part one
puts forms.sum { |f| f.gsub(/[^a-z]/i, "").chars.uniq.count }
