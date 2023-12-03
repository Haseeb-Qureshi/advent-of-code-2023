GRID = File.readlines('data03.txt').map(&:chomp)
DIGITS = (0..9).map(&:to_s)
NON_SYMBOLS = DIGITS + ['.']

def neighbors(i, j)
  [
    [i - 1, j - 1],
    [i, j - 1],
    [i + 1, j - 1],
    [i - 1, j],
    [i + 1, j],
    [i - 1, j + 1],
    [i, j + 1],
    [i + 1, j + 1],
  ].select { |(i2, j2)| i2 >= 0 && j2 >= 0 && GRID[i2] && GRID[i2][j2] }
end

# Part 1


sum = 0
GRID.each_index do |i|
  j = 0
  while j < GRID[0].length
    # If this is a non-digit, skip
    if !DIGITS.include?(GRID[i][j])
      j += 1
    else
      # If this is a number, keep reading forward until there are no more digits to read
      number = ''
      is_adjacent = false
      while DIGITS.include?(GRID[i][j])
        number += GRID[i][j]
        if neighbors(i, j).any? { |i2, j2| !NON_SYMBOLS.include?(GRID[i2][j2]) }
          is_adjacent = true
        end
        j += 1
      end
      sum += number.to_i if is_adjacent
    end
  end
end

puts sum
