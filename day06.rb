time, distance = File.readlines('data06.txt').map { |l| l.split[1..-1].map(&:to_i) }

def wait_for(x, time)
  x * (time - x)
end

# Part 1

winning_strats = []
time.length.times do |race|
  ways_to_win = 0
  time[race].times do |hold_time|
    ways_to_win += 1 if wait_for(hold_time, time[race]) > distance[race]
  end
  winning_strats << ways_to_win
end

puts winning_strats.reduce(:*)

# Part 2

t, d = File.readlines('data06.txt').map { |l| l.split[1..-1].join }.map(&:to_i)

# Use the quadratic equation!
higher = ((-t - Math.sqrt(t ** 2 - (4 * d))) / -2).ceil
lower = ((-t + Math.sqrt(t ** 2 - (4 * d))) / -2).ceil

puts higher - lower
