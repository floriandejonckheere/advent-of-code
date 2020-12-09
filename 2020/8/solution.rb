#!/usr/bin/env ruby

# frozen_string_literal: true

require "byebug"

program = File
  .read("./input.txt")
  .split("\n")
  .map { |l| [l.split[0], l.split[1].to_i] }

# Part one
pc = 0
acc = 0
exe = []

loop do
  break if exe.include? pc

  exe << pc

  op, adr = program[pc]

  case op
  when "jmp"
    pc += adr
  when "acc"
    acc += adr
    pc += 1
  else pc += 1
  end
end

puts acc

# Part two
class CycleError < StandardError; end

def execute(program, pc = 0, acc = 0, exe = [], offset = 0)
  puts "#{Array.new(offset).join(' ')}executing pc = #{pc}, acc = #{acc}, op = #{program[pc]&.join(' ')}, exe = #{exe.join(':')}, cycle = #{exe.include? pc}"

  if exe.include? pc
    puts "cycled"
    raise CycleError
  end

  exe << pc

  op, adr = program[pc]

  case op
  when nil
    acc
  when "acc"
    execute(program, pc + 1, acc + adr, exe)
  when "jmp"
    execute(program, pc + adr, acc, exe) rescue execute(program, pc + 1, acc + adr, exe, offset + 1)
  when "nop"
    execute(program, pc + 1, acc + adr, exe) rescue execute(program, pc + adr, acc, exe, offset + 1)
  else raise "unknown op: #{op}"
  end
end

puts "#{execute(program, 0, 0, [])} should equal 1023"
