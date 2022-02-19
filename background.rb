class Background
  BACKGROUND_Z_POSITION = 0
  GRAY_COLOR = 0xff_808080

  attr_reader :window

  def initialize(window)
    @window = window
  end

  def draw
    window.draw_rect(
      0, 0,
      window.width, window.height,
      color,
      BACKGROUND_Z_POSITION
    )
  end

  private

  def color
    @color ||= Gosu::Color.argb(GRAY_COLOR)
  end
end
