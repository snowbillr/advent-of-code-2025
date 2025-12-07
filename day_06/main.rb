require_relative '../utils/grid.rb'

class Parser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    rows = []
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        rows << line.strip.split(/\s+/)
      end
    end

    Grid.new(rows: rows)
  end
end

class Day1Solver
  def initialize
    @grid = Parser.new(file_path: 'day_06/input.txt').parse
  end

  def run
    result = 0

    @grid.col_size.times do |i|
      column = @grid.col(i)
      # puts "---#{column}---"

      operator = column.pop
      # puts "operator: #{operator}"

      numbers = column.map(&:to_i)
      # puts "numbers: #{numbers}"
      first_value = numbers.shift

      col_result = numbers.reduce(first_value) do |memo, value|
        case operator
        when '*'
          memo * value
        when '+'
          memo + value
        end
      end

      # puts "= #{col_result}"

      result += col_result
    end

    puts result
  end
end

Day1Solver.new.run
