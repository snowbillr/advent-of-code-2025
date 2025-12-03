class InputParser
  def parse
    ranges = []
    File.open("./day_02/input.txt", "r") do |f|
      raw_ranges = f.read.split(",")
      ranges = raw_ranges.map do |raw_range|
        first, last = raw_range.split("-")
        Range.new(first, last)
      end
    end

    ranges
  end
end

class Part1Solver
  def initialize
    @ranges = InputParser.new.parse
  end

  def run
    invalid_ids = []
    @ranges.each do |range|
      range.each do |number|
         s = number.to_s
         max_iterations = (s.length / 2).floor + 1
        #  print "#{s} (#{max_iterations}): "
         max_iterations.times do |i|
            next if i.zero?

            substring = s[0, i]
            # print("#{substring} - ")
            if s =~ Regexp.new("^(#{substring})+$")
              invalid_ids << s
              break
            end
          end
          # puts ''
      end
    end

    puts invalid_ids.map(&:to_i).sum
  end
end

Part1Solver.new.run