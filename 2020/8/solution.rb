#!/usr/bin/env ruby

# frozen_string_literal: true

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
  return true, pc, acc if exe.include? pc

  exe << pc

  op, adr = program[pc]

  case op
  when nil
    acc
  when "acc"
    pc += 1
    acc += adr
    execute(program, pc, acc, exe, offset)
  when "jmp"
    pc += adr
    execute(program, pc, acc, exe)
  when "nop"
    pc += 1
    execute(program, pc, acc, exe)
  end
end


program.each_with_index do |(op, adr), i|
  if op == "jmp" || op == "nop"
    prg = program.dup
    prg[i][0] = (op == "jmp" ? "nop" : "jmp")
  else
    prg = program
  end

  puts execute(prg)
rescue CycleError
  next
end
