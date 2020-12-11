#!/usr/bin/env ruby

# frozen_string_literal: true

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

# Part two
def zip(m, a, b)
  a.zip(b).select { |(c, r)| !c.nil? && !r.nil? && m[r][c] != "." }.first
end

def adjacent2(m, r, c)
  dim_r = m.count
  dim_c = m.transpose.count

  # CL (horizontal)
  cl = (0..(c-1)).to_a.reverse
  hl = [cl.select { |i| m[r][i] != "." }.first, r]

  # CR
  cr = ((c+1)..(dim_c-1)).to_a
  hr = [cr.select { |i| m[r][i] != "." }.first, r]

  # RU (vertical)
  ru = (0..(r-1)).to_a.reverse
  vu = [c, ru.select { |i| m[i][c] != "." }.first]

  # RD
  rd = ((r+1)..(dim_r-1)).to_a
  vd = [c, rd.select { |i| m[i][c] != "." }.first]

  [
    hl, # Horizontal left
    hr, # Horizontal right
    vu, # Vertical up
    vd, # Vertical down
    zip(m, cl, ru), # Left up
    zip(m, cl, rd), # Left down
    zip(m, cr, ru), # Right up
    zip(m, cr, rd), # Right down
  ]
    .compact
    .count { |(c, r)| !c.nil? && !r.nil? && m[r][c] == "#" }
end

def mutate2(matrix)
  adj = {}

  matrix.map(&:dup).each_with_index do |row, r|
    row.each_with_index do |elem, c|
      (adj[r] ||= {})[c] ||= adjacent2(matrix, r, c)

      row[c] = "#" if elem == "L" && adj[r][c] == 0
      row[c] = "L" if elem == "#" && adj[r][c] >= 5
    end
  end
end

i = 0
prev = seats

loop do
  i += 1

  new = mutate2(prev)

  break if new.flatten == prev.flatten

  prev = new
end

puts prev.flatten.count { |c| c == "#" }
