data = File.readlines('data04.txt')
CARDS = data.map do |card|
  winners, mine = card.split(': ').last.chomp.split(' | ')
  winners = Set.new(winners.split.map(&:to_i))
  mine = mine.split.map(&:to_i)
  [winners, mine]
end

def num_matches(winners, mine)
  mine.count { |el| winners.include?(el) }
end


# Part 1
score = 0
CARDS.each do |(winners, mine)|
  matches = num_matches(winners, mine)
  score += 2 ** (matches - 1) if matches > 0
end

puts score
