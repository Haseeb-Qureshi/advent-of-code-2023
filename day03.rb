GRID = File.readlines('data03.txt').map(&:chomp)
DIGITS = (0..9).map(&:to_s)
NON_SYMBOLS = DIGITS + ['.']

def neighbors(i, j)
  [i + 1, i - 1, i].flat_map { |i2| [[i2, j - 1], [i2, j], [i2, j + 1]] }
                   .reject { |i2, j2| [i, j] == [i2, j2] }
                   .select { |(i2, j2)| i2 >= 0 && j2 >= 0 && GRID[i2] && GRID[i2][j2] }
end

def number?(i, j)
  DIGITS.include?(GRID[i][j])
end

# Part 1

sum = 0
GRID.each_index do |i|
  j = 0
  while j < GRID[0].length
    # If this is a non-digit, skip
    if !number?(i, j)
      j += 1
    else
      # If this is a number, keep reading forward until there are no more digits to read
      number = ''
      is_adjacent = false
      while number?(i, j)
        number += GRID[i][j]
        is_adjacent = true if neighbors(i, j).any? { |i2, j2| !NON_SYMBOLS.include?(GRID[i2][j2]) }
        j += 1
      end
      sum += number.to_i if is_adjacent
    end
  end
end

puts sum

# Part 2

GEAR = '*'

def adjacent_numbers(i, j)
  visited = neighbors(i, j).select { |i2, j2| number?(i2, j2) }.
                            reduce({}) { |h, el| h[el] = false; h }
  numbers = []
  visited.each_key do |(i2, j2)|
    next if visited[[i2, j2]]
    visited[[i2, j2]] = true if visited.has_key?([i2, j2])
    # go to beginning of number
    j2 -= 1 until !number?(i2, j2 - 1) || j2 == 0
    # read off to end of number, marking everything as visited so as not to double-count
    number = ''
    while number?(i2, j2)
      number += GRID[i2][j2]
      visited[[i2, j2]] = true if visited.has_key?([i2, j2])
      j2 += 1
    end
    numbers << number unless number.empty?
  end
  numbers.map(&:to_i)
end

sum = 0
GRID.each_index do |i|
  GRID[i].length.times do |j|
    if GRID[i][j] == GEAR
      adjacents = adjacent_numbers(i, j)
      sum += adjacents.reduce(:*) if adjacents.length == 2
    end
  end
end

puts sum
