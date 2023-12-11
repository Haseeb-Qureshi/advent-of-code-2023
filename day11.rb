grid = File.readlines('data11.txt').map(&:chomp).map(&:chars)

cols = Hash.new(false)
rows = Hash.new(false)

grid.each_index do |i| # each row
  rows[i] = grid[i].all? { |c| c == '.' }
end
grid[0].each_index do |j| # each column
  cols[j] = grid.all? { |row| row[j] == '.' }
end

galaxies = []
grid.each_index do |i|
  grid[i].each_index do |j|
    galaxies << [i, j] if grid[i][j] == '#'
  end
end

def dist(a, b, cols, rows, modifier: 2)
  i1, j1 = a
  i2, j2 = b
  i1, i2 = [i1, i2].sort
  j1, j2 = [j1, j2].sort
  i_modifier = (i1..i2).count { |i| rows[i] } * (modifier - 1)
  j_modifier = (j1..j2).count { |j| cols[j] } * (modifier - 1)
  i2 - i1 + i_modifier + j2 - j1 + j_modifier
end

# Part 1

puts galaxies.combination(2).to_a.sum { |a, b| dist(a, b, cols, rows) }

# Part 2

puts galaxies.combination(2).to_a.sum { |a, b| dist(a, b, cols, rows, modifier: 1_000_000) }
