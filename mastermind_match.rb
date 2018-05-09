include "./turn"

class MastermindMatch
  POSSIBLE_COLORS = ["red", "blue", "yellow", "green", "purple", "cyan",
                     "black", "white", "gray", "brown"]
                     
  def initialize(number_of_colors, number_of_turns)
    @colors = POSSIBLE_COLORS.slice(0, number_of_colors)
    @number_of_turns = number_of_turns
    
    @turns = []
    @solution = []
    4.times { @solution.push(@colors.sample) }
  end
  
  def take_turn(guess_colors)
    @turns.push(Turn.new(guess_colors))
  end
end