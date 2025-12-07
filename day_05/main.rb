class Parser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    fresh_ranges = []
    ids = []
    
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        if /-/ =~ line
          fresh_ranges << Range.new(*line.chomp.split('-').map(&:to_i))
        else
          ids << line.chomp.to_i
        end
      end
    end

    [fresh_ranges, ids]
  end
end

class Day1Solver
  def initialize
    @fresh_ranges, @ids = Parser.new(file_path: './day_05/input.txt').parse
  end

  def run
    previous_size = @fresh_ranges.length
    loop do
      @fresh_ranges = collapse_ranges

      break if previous_size == @fresh_ranges.length
      previous_size = @fresh_ranges.length
    end

    fresh_ids = []

    @ids.each do |id|
      @fresh_ranges.each do |range|
        if range.include? id
          fresh_ids << id
          break
        end
      end
    end

    puts fresh_ids.count
  end

  private def collapse_ranges
    collapsed_ranges = []
    loop do
      target_range = @fresh_ranges.shift
      absorbed_indices = []

      @fresh_ranges.each_with_index do |range, i|
        if target_range.overlap? range
         target_range = Range.new([target_range.begin, range.begin].min, [target_range.end, range.end].max) 
         absorbed_indices << i
        end
      end

      absorbed_indices.each { |i| @fresh_ranges[i] = nil }
      @fresh_ranges.filter! { |r| r != nil }

      collapsed_ranges << target_range

      break if @fresh_ranges.length.zero?
    end

    collapsed_ranges
  end
end

class Day2Solver
  def initialize
    @fresh_ranges, _unused = Parser.new(file_path: './day_05/input.txt').parse
  end

  def run
    previous_size = @fresh_ranges.length
    loop do
      @fresh_ranges = collapse_ranges

      break if previous_size == @fresh_ranges.length
      previous_size = @fresh_ranges.length
    end

    puts @fresh_ranges.map(&:size).sum
  end

  private def collapse_ranges
    collapsed_ranges = []
    loop do
      target_range = @fresh_ranges.shift
      absorbed_indices = []

      @fresh_ranges.each_with_index do |range, i|
        if target_range.overlap? range
         target_range = Range.new([target_range.begin, range.begin].min, [target_range.end, range.end].max) 
         absorbed_indices << i
        end
      end

      absorbed_indices.each { |i| @fresh_ranges[i] = nil }
      @fresh_ranges.filter! { |r| r != nil }

      collapsed_ranges << target_range

      break if @fresh_ranges.length.zero?
    end

    collapsed_ranges
  end
end

# Day1Solver.new.run
Day2Solver.new.run
