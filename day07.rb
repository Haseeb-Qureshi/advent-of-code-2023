hands = File.readlines('data07.txt')
            .map(&:chomp)
            .map do |line|
              cards, bid = line.split
              [cards.chars, bid.to_i]
            end

HANDS = [
  -> (h) { h.uniq.count == 5 }, # 0 high card
  -> (h) { h.uniq.count == 4 }, # 1 pair,
  -> (h) { h.tally.values.tally[2] == 2 }, # 2 two pair
  -> (h) { h.uniq.count == 3 }, # 3 trips
  -> (h) { h.uniq.count == 2 && h.tally.values.max == 3  }, # full house
  -> (h) { h.tally.values.max == 4  }, # quads
  -> (h) { h.uniq.count == 1 }, # five of a kind
]

def ordering(c)
  'AKQJT98765432'.chars.reverse.index(c)
end

def hand_rank(h)
  HANDS.index { |l| l.call(h) }
end

def hand_value(h)
  h.each_with_index.reduce(0) do |sum, (char, i)|
    sum + (16 ** (4 - i)) * ordering(char)
  end + hand_rank(h) * 16 ** 6
end

# Part 1

hands.sort_by! { |(h, bid)| hand_value(h) }
puts hands.each_with_index.reduce(0) { |sum, (el, i)| el[1] * (i + 1) + sum }

# Part 2

def joker_ordering(c)
  'AKQT98765432J'.chars.reverse.index(c)
end

def joker_hand_value(h)
  h.each_with_index.reduce(0) do |sum, (char, i)|
    sum + (16 ** (4 - i)) * joker_ordering(char)
  end + hand_rank(transform_jokers(h)) * 16 ** 6
end

def transform_jokers(h)
  most_common = most_common_nonjoker(h)
  h.join.gsub('J', most_common).chars
end

def most_common_nonjoker(h)
  return 'A' if h.join == 'JJJJJ'
  h.tally.reject { |k, v| k == 'J' }
       .max_by { |k, v| v }
       .first
end

jokered_hands = File.readlines('data07.txt')
                    .map(&:chomp)
                    .map do |line|
                      hand, bid = line.split
                      [hand.chars, bid.to_i]
                    end

jokered_hands.sort_by! { |(h, bid)| joker_hand_value(h) }
puts jokered_hands.each_with_index.reduce(0) { |sum, (el, i)| el[1] * (i + 1) + sum }
