class Cell
  CELL_Z_POSITION = 1
  GREEN_COLOR = 0xff_00ff00
  WHITE_COLOR = 0xff_ffffff
  MAX_AGE = 10

  attr_reader :current_value, :prev_value, :next_value, :toggled
  attr_reader :age

  def initialize(alive: true)
    @current_value = alive
    @prev_value = alive
    @drawed = false
    @toggled = false

    @age = alive? ? 1 : 0
  end

  alias alive? current_value

  def draw(x:, y:, size:, window:, alpha: 0xff)
    window.draw_rect(
      x*size, y*size,
      size - 1, size - 1,
      Gosu::Color.argb(color(alpha)),
      CELL_Z_POSITION
    )
  end

  def birth!
    @next_value = true
    @age = 0
  end

  def death!
    @next_value = false
  end

  def toggle!
    return if toggled

    value = !alive?

    @prev_value = value
    @current_value = value
    @prev_value = value
    @age = 0
    @toggled = true
  end

  def commit!
    @toggled = false
    return if next_value.nil?

    if next_value == current_value && alive?
      @age += 1 if @age < MAX_AGE
    end

    @prev_value = current_value
    @current_value = next_value
  end

  private

  def color(alpha)
    if prev_value == current_value
      if alive?
        GREEN_COLOR - age * 10 * 0x100
      else
        WHITE_COLOR
      end
    else
      if alive? # Born
        WHITE_COLOR - alpha - alpha * 0x10000
      else # Death
        GREEN_COLOR + alpha + alpha * 0x10000
      end
    end
  end
end
