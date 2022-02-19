class Map
  attr_reader :area, :x_amount, :y_amount

  def initialize(x_amount, y_amount)
    @x_amount = x_amount
    @y_amount = y_amount

    @area = Array.new(y_amount) do |y|
      Array.new(x_amount) do |x|
        Cell.new(alive: filled_pattern(x, y))
      end
    end
  end

  def each
    area.each.with_index do |row, y_index|
      row.each.with_index do |cell, x_index|
        yield(
          x: x_index,
          y: y_index,
          cell: cell,
          neighbours: neighbours(y_index, x_index)
        )
      end
    end
  end

  def commit!
    each do |x:, y:, cell:, neighbours:|
      cell.commit!
    end
  end

  def cell(x, y)
    area[y][x]
  end

  private

  def filled_pattern(_x, _y)
    false
    #rand(2) == 0
  end

  def neighbours(y_index, x_index)
    x_prev = x_index - 1
    y_prev = y_index - 1
    x_next = x_index + 1 < x_amount ? x_index + 1 : 0
    y_next = y_index + 1 < y_amount ? y_index + 1 : 0

    [
      area[y_prev][x_prev],  # Top left
      area[y_prev][x_index], # Top
      area[y_prev][x_next],  # Top right
      area[y_index][x_prev], # Left
      area[y_index][x_next], # Right
      area[y_next][x_prev],  # Bottom left
      area[y_next][x_index], # Bottom
      area[y_next][x_next],  # Bottom right
    ]
  end
end
