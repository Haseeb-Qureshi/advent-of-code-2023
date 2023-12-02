DATA = File.readlines('data01.txt').map(&:chomp)

# Part 1

def first_num(s)
  s.chars.find { |c| c[/\d/] }
end

calibration_values = DATA.map do |s|
  (first_num(s) + first_num(s.reverse)).to_i
end

puts calibration_values.sum

# Part 2
