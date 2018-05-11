require "./turn"

class MastermindMatch
  attr_accessor :game_state, :solution, :colors, :turns

  POSSIBLE_COLORS = ["red", "blue", "yellow", "green", "purple", "cyan",
                     "black", "white", "gray", "brown"]
                     
  def initialize(number_of_colors, number_of_turns)
    @colors = POSSIBLE_COLORS.slice(0, number_of_colors)
    @number_of_turns = number_of_turns
    @turns = []
    @game_state = :ongoing

    @solution = []
    4.times { @solution.push(@colors.sample) }
  end

  def to_s
    result = "Guesses#{" " * 25}| Feedback#{" " * 16}\n"\
             "#{"-" * 32}|#{"-" * 25}\n"
    @turns.each { |turn| result << turn.to_s + "\n" }
    result
  end
  
  def take_turn(guess_colors)
    @turns.push(Turn.new(guess_colors, @solution))
    if @turns.last.response_colors == ["red", "red", "red", "red"]
      @game_state = :win
    else
      @game_state = :lose if @number_of_turns == @turns.length
    end
  end
end
