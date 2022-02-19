class Info
  LABELS_Z_POSITION = 1000
  BLACK_COLOR = 0xff_000000
  FONT_SIZE = 20

  attr_reader :font

  def initialize
    @font = Gosu::Font.new(FONT_SIZE)
  end

  def draw(window)
    draw_text(<<-TEXT)
      Frequency: #{window.tick_frequency}
      Tick num: #{window.get_tick}
      Till update: #{window.tick_frequency - (window.get_tick % window.tick_frequency)}
    TEXT
  end

  private

  def draw_text(text)
    text.each_line.with_index do |line, index|
      font.draw_text(
        line,                          # text
        10,                            # x
        font.height * (index + 1),     # y
        LABELS_Z_POSITION,             # z
        1,                             # scale_x
        1,                             # scale_y
        Gosu::Color.argb(BLACK_COLOR), # color
        :default                       # mode
      )
    end
  end
end
