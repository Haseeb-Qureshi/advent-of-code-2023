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

# Part 2
MEMO = {}

def matching_cards(i, winners, mine)
  return MEMO[i] if MEMO[i]
  matches = num_matches(winners, mine)
  # truncate lookahead
  max = CARDS.length - 1
  matches = max - i if max < i + matches
  num_cards = 1

  matches.times do |j|
    look_ahead = i + j + 1
    new_winners, new_mine = CARDS[look_ahead]
    num_cards += matching_cards(look_ahead, new_winners, new_mine)
  end
  MEMO[i] = num_cards
end

puts CARDS.map.with_index { |(w, m), i| matching_cards(i, w, m) }.sum
