DATA = File.readlines('data02.txt').map(&:chomp)

games = Hash.new() { |h, k| h[k] = [] }
DATA.each_with_index do |line, i|
  # Game 1: 10 red, 7 green, 3 blue; 5 blue, 3 red, 10 green
  game = line.split(': ').last.split(';')
  # [{10 red, 7 green, 3 blue}, {3 red, 10 green}]
  game.map do |pull|
    # "10 red, 7 green"
    pull_map = pull.split(', ').reduce({}) do |h, balls|
      num, color = balls.split
      h[color] = num.to_i
      h
    end
    games[i + 1] << pull_map
  end
end

# Part 1

RED_LIMIT = 12
GREEN_LIMIT = 13
BLUE_LIMIT = 14
RED = 'red'
GREEN = 'green'
BLUE = 'blue'

def pull_possible?(pull)
  (pull[BLUE] || 0) <= BLUE_LIMIT &&
    (pull[RED] || 0) <= RED_LIMIT &&
    (pull[GREEN] || 0) <= GREEN_LIMIT
end

total_id_sum = games.sum do |id, game|
  game.all? { |pull| pull_possible?(pull) } ? id : 0
end

puts total_id_sum

# Part 2

# Power: the multiplied together minimum number of red, blue, green
power_sum = games.values.sum do |game|
  max_red, max_blue, max_green = 0, 0, 0
  game.each do |pull|
    max_red = [(pull[RED] || 0), max_red].max
    max_blue = [(pull[BLUE] || 0), max_blue].max
    max_green = [(pull[GREEN] || 0), max_green].max
  end
  max_red * max_blue * max_green
end

puts power_sum
