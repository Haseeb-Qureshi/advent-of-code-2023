input = File.readlines("data08.txt").map(&:chomp)

DIRECTIONS = input.shift.chars
input.shift

NODES = input.each_with_object({}) do |line, h|
  origin, dirs = line.split(' = ')
  h[origin] = dirs[1..-2].split(', ')
end

L = 'L'
R = 'R'

# Part 1

current = 'AAA'
steps = 0
next_direction = DIRECTIONS.cycle
until current == 'ZZZ'
  steps += 1
  current = NODES[current][next_direction.next == L ? 0 : 1]
end

puts steps
