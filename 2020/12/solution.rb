#!/usr/bin/env ruby

# frozen_string_literal: true

commands = File
  .read("./input.txt")
  .split("\n")
  .map { |l| [l[0], l[1..].to_i] }

# Part one
class Boat
  attr_reader :moves, :heading

  def initialize
    @moves = Hash.new(0)
    @heading = "E"
  end

  def move(command, n)
    case command
    when "R"
      @heading = { "E" => "S", "S" => "W", "W" => "N", "N" => "E" }[heading]
    when "L"
      @heading = { "E" => "N", "N" => "W", "W" => "S", "S" => "E" }[heading]
    when "F"
      moves[heading] += n
    else
      moves[command] += n
    end
  end

  def distance
    (moves["E"] - moves["W"]).abs + (moves["N"] - moves["S"]).abs
  end
end

boat = Boat.new
commands.each { |(c, n)| boat.move(c, n) }
puts boat.distance
