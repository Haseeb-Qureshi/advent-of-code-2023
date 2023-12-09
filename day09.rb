LINES = File.readlines('data09.txt').map { |l| l.chomp.split.map(&:to_i) }

def line_to_final_value(line)
  diffs = [line.each_cons(2).map { |a, b| b - a}]
  until diffs.last.all?(&:zero?)
    diffs << diffs.last.each_cons(2).map { |a, b| b - a }
  end
  ([line] + diffs).map(&:last).sum
end

# Part 1

puts LINES.sum { |line| p line_to_final_value(line) }
