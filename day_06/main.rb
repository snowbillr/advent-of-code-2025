require_relative '../utils/grid.rb'

class Parser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    rows = []
    File.open(@file_path, 'r') do |f|
      row = []

      f.each_line do |line|
        remaining_line = line.chomp
        loop do
          match, rest_of_line = match_first_value(remaining_line)

          row << match
          remaining_line = rest_of_line

          break if remaining_line.nil?
        end
      end

      rows << row
    end

    Grid.new(rows: rows)
  end

  private def match_first_value(line)
    alignment = if line.start_with?(' ')
      'right'
    else
      'left'
    end

    puts "---#{line}---"

    match = if alignment == 'right'
      /(\s+\d+)\s/.match(line) 
    elsif alignment == 'left'
      /(\d+\s*?)($|\s)/.match(line)
    end

    # if end of string /\d+\s*$/
    # then the other conditions

    if match.nil?
      puts "nil match (eod):#{line}"
      [line, nil]
    else
      puts "#{alignment}:'#{match[1]}' - '#{match.post_match}'"
      [match[1], match.post_match]
    end
  end
end

class Day1Solver
  def initialize
    @grid = Parser.new(file_path: 'day_06/test-input.txt').parse

    @grid.print
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

Day1Solver.new
