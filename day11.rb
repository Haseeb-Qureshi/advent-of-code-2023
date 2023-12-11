raw_grid = File.readlines('data11.txt').map(&:chomp).map(&:chars)

# raw_grid = '...#......
# .......#..
# #.........
# ..........
# ......#...
# .#........
# .........#
# ..........
# .......#..
# #...#.....'.lines.map(&:chomp).map(&:chars)

cols = Hash.new(false)
rows = Hash.new(false)

raw_grid.each_index do |i| # each row
  rows[i] = raw_grid[i].all? { |c| c == '.' }
end
raw_grid[0].each_index do |j| # each column
  cols[j] = raw_grid.all? { |row| row[j] == '.' }
end

grid = []
new_length = cols.length + cols.values.count(&:itself)

raw_grid.each_with_index do |row, i|
  if row.all? { |c| c == '.' }
    2.times { grid << ['.'] * new_length }
  else
    new_line = []
    row.each_with_index do |c, j|
      if cols[j]
        2.times { new_line << '.' }
      else
        new_line << c
      end
    end
    grid << new_line
  end
end

# shortest distances between galaxies
galaxies = []
grid.each_index do |i|
  grid[i].each_index do |j|
    galaxies << [i, j] if grid[i][j] == '#'
  end
end

def dist(a, b)
  i1, j1 = a
  i2, j2 = b
  (i1 - i2).abs + (j1 - j2).abs
end

puts galaxies.combination(2).to_a.sum { |a, b| dist(a, b) }
