require 'gosu'

require 'pry'
require_relative './background'
require_relative './cell'
require_relative './map'

class Life < Gosu::Window
  X_AMOUNT = 100
  Y_AMOUNT = 70
  CELL_SIZE = 10

  def initialize
    super(X_AMOUNT * CELL_SIZE, Y_AMOUNT * CELL_SIZE)
    self.caption = 'The game of life'

    @background = Background.new(self)
    @map = Map.new(X_AMOUNT, Y_AMOUNT)
  end

  def update
  end

  def draw
    @background.draw
    draw_map
  end

  private

  def draw_map
    @map.each do |x:, y:, cell:, neighbours:|
      cell.draw(x: x, y: y, size: CELL_SIZE, window: self)
    end
  end
end

Life.new.show
