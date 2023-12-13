GRID = File.readlines('data10.txt').map(&:chomp).map(&:chars)

# GRID = '..F7.
# .FJ|.
# SJ.L7
# |F--J
# LJ...'.lines.map(&:chomp).map(&:chars)

GROUND = '.'
ANIMAL = 'S'
DIFFS = {
  '|' => [[1, 0], [-1, 0]],
  '-' => [[0, 1], [0, -1]],
  'L' => [[-1, 0], [0, 1]],
  'J' => [[-1, 0], [0, -1]],
  '7' => [[1, 0], [0, -1]],
  'F' => [[1, 0], [0, 1]],
}

def neighbors(i, j)
  [
    [i, j + 1],
    [i, j - 1],
    [i + 1, j],
    [i - 1, j]
  ].select { |(i2, j2)| i2 >= 0 && j2 >= 0 && GRID[i2] && GRID[i2][j2] && GRID[i2][j2] != GROUND }
end

def valid_move?(i1, j1, i2, j2)
  char = GRID[i2][j2]
  return false if char == '.'
  raise "WTF: #{char}" unless DIFFS[char]
  diff = [i1 - i2, j1 - j2]
  DIFFS[char].include?(diff)
end

animal = nil
GRID.each_index { |i| GRID[0].each_index { |j| animal = [i, j] if GRID[i][j] == ANIMAL } }

# try each direction assuming that they are each valid

def find_path(origin)
  eligible_paths = []
  queue = neighbors(*origin).map { |(i, j)| [i, j, [origin]] }
  until queue.empty?
    i, j, path = queue.shift
    char = GRID[i][j]
    next if char == GROUND
    if char == ANIMAL
      eligible_paths << path
      next
    end
    # i don't care if i've already visited; impossible for there to be another loop
    # look up what's the next node to connect to
    last_node = path.last
    next_node_diff = DIFFS[char].reject { |di, dj| [i + di, j + dj] == last_node }.flatten
    next_node = [i, j].zip(next_node_diff).map(&:sum)

    verbose = false
    if verbose
      puts "queue: #{queue.map { |q| q.first(2)}}"
      puts "piece: ~ #{char} ~"
      puts "origin: #{origin}"
      puts "i, j: #{i}, #{j}"
      puts "last node: #{last_node}"
      puts "Diffs: #{DIFFS[char]}, next_node_diff: #{next_node_diff}"
      puts "path: #{path}"
      puts "next node: #{next_node}"
      g = GRID.map(&:join)
      path.each { |(i, j)| g[i][j] = 'x' }
      g[i][j] = 'X'
      puts g.join("\n")
      puts "-" * 8
      puts
    end
    queue << [*next_node, path + [[i, j]]]
  end
  eligible_paths
end

# Part 1

paths = find_path(animal)
puts paths.map(&:length).max / 2
