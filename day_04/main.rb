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

    Grid.new(rows: rows)
  end
end

class Grid
  PAPER_CELL = '@'
  EMPTY_CELL = '.'

  def initialize(rows:)
    @rows = rows
  end

  def neighbors(row, col)
    top_left = @rows.dig(row - 1, col - 1) if row - 1 >= 0 and col - 1 >= 0
    top_middle = @rows.dig(row - 1, col) if row - 1 >= 0
    top_right = @rows.dig(row - 1, col + 1) if row - 1 >= 0 and col + 1 < @rows[row].length
    left = @rows.dig(row, col - 1) if col - 1 >= 0
    right = @rows.dig(row, col + 1) if col + 1 < @rows[row].length
    bottom_left = @rows.dig(row + 1, col - 1) if row + 1 < @rows.length and col - 1 >= 0
    bottom_middle = @rows.dig(row + 1, col) if row + 1 < @rows.length
    bottom_right = @rows.dig(row + 1, col + 1) if row + 1 < @rows.length and col + 1 < @rows[row].length

    [
      top_left, top_middle, top_right,
      left, right,
      bottom_left, bottom_middle, bottom_right
    ]
  end

  def each(&block)
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        block.yield(cell, row_index, column_index)
      end
    end
  end

  def at(row, col)
    @rows[row][col]
  end

  def print
    @rows.each do |row|
      puts row
    end
  end
end

class Day1Solver
  def initialize
    @grid = Parser.new(file_path: './day_04/input.txt').parse
  end

  def run
    accessible_rolls_of_paper_count = 0

    @grid.each do |cell, row, col|
      next if cell == Grid::EMPTY_CELL

      # puts "---#{row}, #{col}---"

      paper_neighbors = @grid.neighbors(row, col)
        .filter { |cell| cell == Grid::PAPER_CELL }
      # puts "neighbors: #{paper_neighbors}"

      accessible_rolls_of_paper_count += 1 if paper_neighbors.count < 4
    end

    puts accessible_rolls_of_paper_count
  end
end

Day1Solver.new.run