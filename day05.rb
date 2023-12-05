class RangeMap < Hash
  def initialize
    super
    @ranges = []
  end

  def add_range(destination, source, span)
    source_range = (source..(source + span - 1))
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

lowest_location = seeds.map do |seed|
  current = seed
  range_maps.each do |range_map|
    current = range_map[current]
  end
  current
end.min

puts lowest_location
