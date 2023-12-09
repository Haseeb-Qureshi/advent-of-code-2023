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

# Part 2

currents = NODES.keys.select { |k| k[-1] == 'A' }
steps = 0
next_direction = DIRECTIONS.cycle
# count each cycle length; how long until they see a node twice
until currents.all? { |n| n[-1] == 'Z' }
  steps += 1
  current_direction = next_direction.next
  currents.each_index { |i| currents[i] = NODES[currents[i]][current_direction == L ? 0 : 1] }
end

puts steps


# currents = NODES.keys
#                 .select { |k| k[-1] == 'A' }}
#                 .map { |k| [k, { k => 0 }, nil]}
# steps = 0
# next_direction = DIRECTIONS.cycle
# # count each cycle length; how long until they see a node twice?
# until currents.none? { |_, _, cycle_length| cycle_length.nil? }
#   steps += 1
#   current_direction = next_direction.next
#   currents.each_index do |i|

#     new_node = NODES[currents[i][0]][current_direction == L ? 0 : 1]
#     currents[i][0] = new_node
#     if currents[i][1][new_node]
#       currents[i][2]
#   end
# end
