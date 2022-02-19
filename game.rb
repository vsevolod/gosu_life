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
    @tick = 0
  end

  def update
    every_tick do
      next_step
    end
  end

  def draw
    @background.draw
    draw_map
  end

  private

  def sym(x)
    x.alive? ? 'X' : ' '
  end

  def next_step
    @map.each do |x:, y:, cell:, neighbours:|
      alive_neighbours_count = neighbours.count(&:alive?)

      if cell.alive?
        cell.death! unless [2, 3].include?(alive_neighbours_count)
      else
        cell.birth! if alive_neighbours_count == 3
      end
    end

    @map.commit!
  end

  def draw_map
    @map.each do |x:, y:, cell:, neighbours:|
      cell.draw(x: x, y: y, size: CELL_SIZE, window: self)
    end
  end

  def every_tick
    @tick += 1
    yield if @tick % 20 == 0
    @tick = 0 if @tick == 10_000_000
  end
end

Life.new.show
