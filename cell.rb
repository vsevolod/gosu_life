class Cell
  CELL_Z_POSITION = 1
  GREEN_COLOR = 0xff_00ff00
  WHITE_COLOR = 0xff_ffffff

  attr_reader :alive
  attr_reader :next_value

  def initialize(alive: true)
    @alive = alive
  end

  alias alive? alive

  def draw(x:, y:, size:, window:)
    window.draw_rect(
      x*size, y*size,
      size - 1, size - 1,
      color,
      CELL_Z_POSITION
    )
  end

  def birth!
    @next_value = true
  end

  def death!
    @next_value = false
  end

  def commit!
    @alive = @next_value
  end

  private

  def color
    if alive?
      Gosu::Color.argb(GREEN_COLOR)
    else
      Gosu::Color.argb(WHITE_COLOR)
    end
  end
end
