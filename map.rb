class Map
  attr_reader :area, :x_amount, :y_amount

  def initialize(x_amount, y_amount)
    @x_amount = x_amount
    @y_amount = y_amount

    @area = Array.new(x_amount) do |y|
      Array.new(y_amount) do |x|
        Cell.new(filled: filled_pattern(x, y))
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

  private

  def filled_pattern(_x, _y)
    rand(2) == 0
  end

  def neighbours(y_index, x_index)
    x_next = x_index + 1 < x_amount ? x_index + 1 : 0
    y_next = y_index + 1 < y_amount ? y_index + 1 : 0

    {
      left:  area[y_index][x_index - 1],
      top:   area[y_index - 1][x_index],
      right: area[y_index][x_next],
      down:  area[y_next][x_index],
    }
  end
end
