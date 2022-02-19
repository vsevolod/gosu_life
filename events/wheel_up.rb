module Events
  class WhellUp
    MIN_TICK_FREQUENCY = 4

    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      return if game.tick_frequency <= MIN_TICK_FREQUENCY

      game.tick_frequency -= 1
      puts game.tick_frequency
    end
  end
end
