class Parser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    rows = []
    File.open(@file_path, 'r') do |f|
      f.each_line do |line|
        rows << line.chomp.split('')
      end
    end

    @rows = rows
  end
end

class Beam
  attr_reader :column

  def initialize(column:)
    @column = column
  end

  def pass_through(row:)
    if row[@column] == '^'
      left_beam = @column - 1 >= 0 ? Beam.new(column: @column - 1) : nil
      right_beam = @column + 1 < row.length ? Beam.new(column: @column + 1) : nil

      [
        left_beam,
        right_beam
      ].compact
    else
      []
    end
  end
end

class Part1Solver
  def initialize
    @rows = Parser.new(file_path: 'day_07/input.txt').parse
  end

  def run
    split_beams = []
    active_beams = [
      Beam.new(column: @rows.shift.find_index('S'))
    ]

    @rows.each do |row|
      next_active_beams = []

      # puts " ---#{row}--- "

      # split each beam
      active_beams.each do |beam|
        result = beam.pass_through(row:)
        if result.length.positive?
          next_active_beams.concat(result)
          split_beams << beam
        else
          # puts "beam at #{beam.column} did not split"
          next_active_beams << beam
        end
      end

      # remove duplicate beams
      active_beams = []
      next_active_beams.each do |beam|
        if active_beams.find { |other| other.column == beam.column } == nil
          active_beams << beam
        else
          # puts "duplicate removed at column #{beam.column}"
        end
      end
    end

    puts split_beams.count
  end
end

Part1Solver.new.run