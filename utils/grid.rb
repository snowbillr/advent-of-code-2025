class Grid
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

  def row_size
    @rows.size
  end

  def col_size
    @rows.first.size
  end

  def row(index)
    @rows[index]
  end

  def col(index)
    @rows.map { |r| r[index] }
  end

  def at(row, col)
    @rows[row][col]
  end

  def update(row, col, value)
    @rows[row][col] = value
  end

  def print
    @rows.each do |row|
      puts row.join(' ')
    end
  end
end