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

  opc, adr = program[pc]

  case opc
  when "jmp"
    pc += adr
  when "acc"
    acc += adr
    pc += 1
  else pc += 1
  end
end

puts acc
