GRID = File.readlines('data10.txt').map(&:chomp).map(&:chars)

GRID = '.....
.S-7.
.|.|.
.L-J.
.....'.lines.map(&:chomp).map(&:chars)

GROUND = '.'
DIFFS = {
  '|' => [[1, 0], [-1, 0]],
  '-' => [[0, 1], [0, -1]],
  'L' => [[1, 0], [0, 1]],
  'J' => [[1, 0], [0, -1]],
  '7' => [[-1, 0], [0, -1]],
  'F' => [[-1, 0], [0, 1]],
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

s = nil
GRID.each_index { |i| GRID[0].each_index { |j| s = [i, j] if GRID[i][j] == 'S' } }

# try each direction assuming that they are each valid assuming they have a connector
paths = neighbors(*s)
