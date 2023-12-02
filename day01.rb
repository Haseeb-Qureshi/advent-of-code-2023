DATA = File.readlines('data01.txt').map(&:chomp)

# Part 1

sum = DATA.sum do |s|
  (s[/\d/] + s.reverse[/\d/]).to_i
end

puts sum

# Part 2

WORDS = %w(zero one two three four five six seven eight nine)
NUMS = (0..9).map(&:to_s)
MATCH_REGEX = (WORDS + NUMS).join('|')

def recalibrated_num(s)
  WORDS.index(s) || NUMS.index(s)
end

recalibrated_sum = DATA.sum do |s|
  matches = s.scan(/(?=(#{MATCH_REGEX}))/).flatten
  10 * recalibrated_num(matches[0]) + recalibrated_num(matches[-1])
end

puts recalibrated_sum
