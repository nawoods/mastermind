require "./mastermind_match"
class MastermindAI
  attr_reader :possible_solutions
  
  def initialize(match)
    @possible_solutions = []
    colors = match.colors
    colors.each do |color1|
      colors.each do |color2|
        colors.each do |color3|
          colors.each do |color4|
            @possible_solutions << [color1, color2, color3, color4]
          end
        end
      end
    end
  end
end