require "./turn"

class MastermindMatch
  attr_reader :game_state, :colors, :turns

  POSSIBLE_COLORS = ["red", "blue", "yellow", "green", "purple", "cyan",
                     "black", "white", "gray", "brown"]

  def self.possible_colors(number_of_colors)
    POSSIBLE_COLORS.slice(0, number_of_colors)
  end
                     
  def initialize(number_of_colors, number_of_turns, solution = nil)
    @colors = POSSIBLE_COLORS.slice(0, number_of_colors)
    @number_of_turns = number_of_turns
    @turns = []
    @game_state = :ongoing

    if solution
      @solution = solution
    else
      @solution = []
      4.times { @solution << @colors.sample }
    end
  end

  def to_s
    result = "Guesses#{" " * 25}| Feedback#{" " * 16}\n"\
             "#{"-" * 32}|#{"-" * 25}\n"
    @turns.each { |turn| result << turn.to_s + "\n" }
    result
  end
  
  def take_turn(guess_colors)
    @turns << Turn.new(guess_colors, @solution)
    if @turns.last.response_colors == ["red", "red", "red", "red"]
      @game_state = :win
    else
      @game_state = :lose if @number_of_turns == @turns.length
    end
    @turns.last
  end
  
  def response_colors(guess_colors)
    Turn.new(guess_colors, @solution).response_colors
  end
end
