class Cell
  CELL_Z_POSITION = 1
  GREEN_COLOR = 0xff_00ff00
  WHITE_COLOR = 0xff_ffffff

  attr_accessor :filled

  def initialize(filled:)
    @filled = filled
  end

  def draw(x:, y:, size:, window:)
    window.draw_rect(
      y*size, x*size,
      size - 1, size - 1,
      color,
      CELL_Z_POSITION
    )
  end

  private

  def color
    if filled
      Gosu::Color.argb(GREEN_COLOR)
    else
      Gosu::Color.argb(WHITE_COLOR)
    end
  end
end
