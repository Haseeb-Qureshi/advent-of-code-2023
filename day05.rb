class RangeMap < Hash
  attr_reader :ranges
  def initialize
    super
    @ranges = []
  end

  def add_range(destination, source, span)
    source_range = (source...source + span)
    offset = source - destination
    @ranges << [source_range, offset]
  end

  def [](source)
    applicable_range, offset = @ranges.find { |(r, _)| r.include?(source) }
    return source if applicable_range.nil?
    source - offset
  end
end

input = File.readlines('data05.txt').map(&:chomp)
seeds = input.shift.split(': ').last.split.map(&:to_i)

# Part 1

range_maps = []
until input.empty?
  line = input.shift
  next if line.empty?

  if line[/map:/] # build map
    range_map = RangeMap.new

    until input[0].nil? || input[0].empty?
      line = input.shift
      destination, source, span = line.split.map(&:to_i)
      range_map.add_range(destination, source, span)
    end
    range_maps << range_map
  end
end

def get_location(seed, range_maps)
  range_maps.reduce(seed) { |current, range_map| range_map[current] }
end

puts seeds.map { |seed| get_location(seed, range_maps) }.min

# Part 2

inputs = File.readlines('data05.txt').first.chomp.split[1..-1].map(&:to_i)
seeds = inputs.each_slice(2).map { |start, span| (start...start + span) }

min = Float::INFINITY
seeds.each do |range|
  range.each do |seed|
    loc = get_location(seed, range_maps)
    min = loc if loc < min
  end
end

puts min
