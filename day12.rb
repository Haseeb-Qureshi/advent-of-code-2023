input = File.readlines('data12.txt')
            .map(&:chomp)
            .map { |l| l.split }
            .map { |txt, nums| [txt, nums.split(',').map(&:to_i)]}

IS_HASH = proc { |c| c == '#' }
IS_DOT = proc { |c| c == '.' }
IS_Q = proc { |c| c == '?' }

def arrangements(suffix, nums, cache = {}, not_start_with_hash: false, start_with_hash: false)
  key = [suffix, nums, not_start_with_hash, start_with_hash]
  return cache[key] if cache[key]

  return 1 if suffix.nil? && nums.empty?
  return 0 if suffix.nil?
  return 1 if suffix.empty? && nums.empty?
  return 1 if suffix.chars.none?(&IS_HASH) && nums.empty?
  return 0 if suffix.empty? && nums.any?
  return 0 if suffix.chars.any?(&IS_HASH) && nums.empty?
  return 0 if IS_HASH.(suffix[0]) && not_start_with_hash
  return 0 if start_with_hash && IS_DOT.(suffix[0])

  if nums.first == 1
    case
    when IS_DOT.(suffix[0])
      cache[key] ||= arrangements(suffix[1..-1], nums, cache)
    when IS_HASH.(suffix[0])
      cache[key] ||= arrangements(suffix[1..-1], nums[1..-1], cache, not_start_with_hash: true)
    when IS_Q.(suffix[0])
      ways = 0
      ways += arrangements(suffix[1..-1], nums, cache) unless start_with_hash # it's a .
      ways += arrangements(suffix[1..-1], nums[1..-1], cache, not_start_with_hash: true) unless not_start_with_hash
      cache[key] ||= ways
    else raise "wtf #{suffix}"
    end
  else # it's a longer sequence
    case
    when IS_DOT.(suffix[0])
      cache[key] ||= arrangements(suffix[1..-1], nums, cache)
    when IS_HASH.(suffix[0])
      modified_nums = nums.clone.tap { |a| a[0] -= 1 }
      cache[key] ||= arrangements(suffix[1..-1], modified_nums, cache, start_with_hash: true)
    when IS_Q.(suffix[0])
      modified_nums = nums.clone.tap { |a| a[0] -= 1 }

      ways = 0
      if start_with_hash # only #
        ways += arrangements(suffix[1..-1], modified_nums, cache, start_with_hash: true)
      elsif not_start_with_hash # only .
        ways += arrangements(suffix[1..-1], nums, cache)
      else # try both
        ways += arrangements(suffix[1..-1], modified_nums, cache, start_with_hash: true)
        ways += arrangements(suffix[1..-1], nums, cache)
      end
      cache[key] ||= ways
    else raise "wtf #{suffix}"
    end
  end
end

# Part 1

puts input.sum { |line, nums| arrangements(line, nums) }

# Part 2

sum = input.reduce(0) do |acc, (line, nums)|
  modified_line = ([line] * 5).join('?')
  modified_nums = ([nums] * 5).flatten
  acc + arrangements(modified_line, modified_nums)
end

puts sum
