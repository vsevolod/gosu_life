module Events
  class WhellDown
    MAX_TICK_FREQUENCY = 1000

    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      return if game.tick_frequency >= MAX_TICK_FREQUENCY

      game.tick_frequency += 1
      puts game.tick_frequency
    end
  end
end
