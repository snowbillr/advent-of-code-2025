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
          fresh_ranges << Range.new(*line.chomp.split('-'))
        else
          ids << line.chomp
        end
      end
    end

    [fresh_ranges, ids]
  end
end

class Day1Solver
  def initialize
    @fresh_ranges, @ids = Parser.new(file_path: './day_05/test-input.txt').parse
  end

  def run
    puts @fresh_ranges
    collapsed_ranges = collapse_ranges(@fresh_ranges)
    puts '---'
    puts collapsed_ranges

    collapsed_ranges = collapse_ranges(collapsed_ranges)
    puts '---'
    puts collapsed_ranges
    fresh_ids = []

    @ids.each do |id|
      collapsed_ranges.each do |range|
        if range.include? id
          fresh_ids << id
          break
        end
      end
    end

    puts fresh_ids.count
  end

  private def collapse_ranges(ranges)
    collapsed_ranges = []

    ranges.each_with_index do |a, i|
      new_range = Range.new(a.begin, a.end)
      ranges.slice(i, ranges.length).each do |b|
        if new_range.overlap? b
          new_range = Range.new([a.begin, b.begin].min, [a.end, b.end].max)
        end
      end
      collapsed_ranges << new_range
    end
  end
end

Day1Solver.new.run
