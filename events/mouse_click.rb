module Events
  class MouseClick
    attr_reader :map

    def initialize(map:)
      @map = map
    end

    def call(x, y)
      map.cell(x, y).toggle!
    end
  end
end
