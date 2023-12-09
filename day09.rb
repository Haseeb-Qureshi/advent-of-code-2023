LINES = File.readlines('data09.txt').map { |l| l.chomp.split.map(&:to_i) }

def line_to_final_value(line)
  diffs = [line, line.each_cons(2).map { |a, b| b - a}]
  until diffs.last.all?(&:zero?)
    diffs << diffs.last.each_cons(2).map { |a, b| b - a }
  end
  diffs.map(&:last).sum
end

# Part 1

puts LINES.sum { |line| line_to_final_value(line) }

# Part 2

def line_to_first_value(line)
  diffs = [line, line.each_cons(2).map { |a, b| b - a}]
  until diffs.last.all?(&:zero?)
    diffs << diffs.last.each_cons(2).map { |a, b| b - a }
  end
  diffs.reverse.reduce(0) do |current, diff_array|
    diff_array.first - current
  end
end

puts LINES.sum { |line| line_to_first_value(line) }
