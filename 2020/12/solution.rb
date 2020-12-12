#!/usr/bin/env ruby

# frozen_string_literal: true

commands = File
  .read("./input.txt")
  .split("\n")
  .map { |l| [l[0], l[1..].to_i] }

# Part one
class SimpleBoat
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

boat = SimpleBoat.new
commands.each { |(c, n)| boat.move(c, n) }
puts boat.distance

# Part two
class Boat < Struct.new(:x, :y)
  def move(x, y)
    self.x += x
    self.y += y
  end

  def distance
    x.abs + y.abs
  end
end

class Waypoint < Struct.new(:x, :y)
  def rotate(deg)
    rad = deg * Math::PI / -180
    px = x * Math.cos(rad) - y * Math.sin(rad)
    py = x * Math.sin(rad) + y * Math.cos(rad)

    self.x, self.y = px.round, py.round
  end
end

class Navigator
  attr_reader :boat, :waypoint

  def initialize(commands)
    @boat = Boat.new(0, 0)
    @waypoint = Waypoint.new(10, 1)

    commands.each { |(c, n)| move(c, n) }
  end

  def move(c, n)
    case c
    when "F" then n.times { boat.move(waypoint.x, waypoint.y) }
    when "E" then waypoint.x += n
    when "W" then waypoint.x -= n
    when "N" then waypoint.y += n
    when "S" then waypoint.y -= n
    else waypoint.rotate(n * (c == "R" ? 1 : -1))
    end
  end
end

puts Navigator.new(commands).boat.distance
