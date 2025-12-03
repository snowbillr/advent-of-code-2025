class Parser
    def initialize(file_path)
        @file_path = file_path
    end

    def parse
        lines = []
        File.open(@file_path, "r") do |f|
            f.each_line do |line|
                lines << parse_line(line)
            end
        end
        lines
    end

    private def parse_line(line)
        direction, amount = /(L|R)(\d+)/.match(line).captures

        [direction == "L" ? -1 : 1, amount.to_i]
    end

end

class Part1Solver
    def initialize
        @location = 50
        @zero_counts = 0
    end

    def adjust_location(direction, amount)
        @location += (direction * amount)
        @location %= (0...100).count
    end

    def check_zero_and_count
        @zero_counts += 1 if @location.zero?
    end

    def run
        parser = Parser.new("./day_01/input.txt")
        lines = parser.parse
        lines.each do |line|
            direction, amount = line
            adjust_location(direction, amount)
            check_zero_and_count
        end

        puts(@zero_counts)
    end
end

class Part2Solver
    def initialize
        @location = 50
        @times_passed_zero = 0
    end

    def run
        parser = Parser.new("./day_01/input.txt")
        lines = parser.parse
        lines.each do |line|
            direction, amount = line

            # new_location = calculate_new_location(direction, amount)
            # if (@location.negative? and new_location >= 0) or (@location.positive? and new_location <= 0) or new_location.zero?
            #     # we know we clicked to zero at least once
            # end

            distance_to_zero = if direction.negative?
                @location
            elsif direction.positive?
                100 - @location
            end

            @times_passed_zero += 1 if (amount >= distance_to_zero)
            extra_loops = (amount - distance_to_zero) / 100
            @times_passed_zero += extra_loops

            adjust_location(direction, amount)

            # extra_loops = amount / 100

            # prev_location = @location
            # adjust_location(direction, amount)
            
            # puts(@location)
            # if ((prev_location.negative? and !@location.negative?) or (prev_location.positive? and !@location.negative?)) and (!prev_location.zero?)
            #     @times_passed_zero += 1
            # end
        end

        puts(@times_passed_zero)
    end

    private def calculate_new_location(direction, amount)
        new_location = @location + (direction * amount)
        new_location % 100
    end

    private def adjust_location(direction, amount)
        @location += (direction * amount)
        @location %= 100
    end

    private def log(direction, amount)
        puts("@#{@location} -> #{direction * amount}")
    end
end

# Part1Solver.new.run()
Part2Solver.new.run()