require 'gosu'

require 'pry'
require_relative './background'
require_relative './cell'
require_relative './map'
require_relative './events/mouse_click'
require_relative './events/wheel_up'
require_relative './events/wheel_down'

class Life < Gosu::Window
  X_AMOUNT = 100
  Y_AMOUNT = 70
  CELL_SIZE = 10
  TICK_FREQUENCY = 50

  attr_reader :tick_frequency, :fade_frequency

  def initialize
    super(X_AMOUNT * CELL_SIZE, Y_AMOUNT * CELL_SIZE)
    self.caption = 'The game of life'

    @background = Background.new(self)
    @map = Map.new(X_AMOUNT, Y_AMOUNT)
    @tick = 0
    @draw_mode = false

    @tick_frequency = TICK_FREQUENCY
    @fade_frequency = TICK_FREQUENCY / 4
  end

  def tick_frequency=(new_tick_frequency)
    @tick_frequency = new_tick_frequency
    @fade_frequency = new_tick_frequency / 4
  end

  def update
    draw_cell if @draw_mode

    every_tick do
      next_step
    end
  end

  def draw
    @background.draw
    draw_map
  end

  private

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
    alpha = count_alpha

    @map.each do |x:, y:, cell:, neighbours:|
      cell.draw(
        x: x,
        y: y,
        size: CELL_SIZE,
        window: self,
        alpha: alpha
      )
    end
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      @draw_mode = true
    when Gosu::MsWheelDown
      Events::WhellDown.new(self).call
    when Gosu::MsWheelUp
      Events::WhellUp.new(self).call
    end
  end

  def button_up(id)
    case id
    when Gosu::MsLeft
      @draw_mode = false
    end
  end

  private

  def draw_cell
    Events::MouseClick.new(map: @map).call(
      (mouse_x / CELL_SIZE).floor,
      (mouse_y / CELL_SIZE).floor
    )
  end

  def every_tick
    @tick += 1
    yield if @tick % tick_frequency == 0
    @tick = 0 if @tick == 10_000_000
  end

  def count_alpha
    tick_freq = @tick % tick_frequency
    if tick_freq > fade_frequency
      0xff
    else
      (0xff * (tick_freq * 1.0 / fade_frequency)).to_i
    end
  end
end

Life.new.show
