#!/usr/bin/env ruby

# frozen_string_literal: true

require "set"

rules = File
  .read("./input.txt")
  .split("\n")
  .map { |r| /\A([a-z ]*) bags? contain (.*)\.\z/.match(r)[1..] }
  .to_h
  .transform_values { |v| v.split(",").flat_map { |s| /([0-9]* ([a-z ]*)|no other) bags?/.match(s)[2..] }.compact }

class Node
  attr_reader :label, :neighbours

  def initialize(label)
    @label = label
    @neighbours = []
  end

  def flatten
    neighbours.flat_map(&:flatten).append(label)
  end
end

# Part one
graph = Hash.new { |h, k| h[k] = Node.new(k) }
rules.each { |key, values| values.each { |value| graph[value].neighbours << graph[key] } }

puts graph["shiny gold"].flatten.uniq.count - 1
