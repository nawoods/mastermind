class Turn
  attr_accessor :guess_colors
  
  def initialize(guess_colors, solution)
    @guess_colors = guess_colors
    @solution = solution
  end
  
  def response_colors
    unmatched_guess_colors = []
    unmatched_solution_colors = []
    response = []
    4.times do |i|
      if guess_colors[i] == solution[i]
        response.push("red")
      else
        unmatched_guess_colors.push(guess_colors[i])
        unmatched_solution_colors.push(solution[i])
      end
    end
    
    unmatched_guess_colors.each do |guess_color|
      solution_index = unmatched_solution_colors.index(guess_color)
      next unless solution_index
      response.push("white")
      unmatched_solution_colors.slice!(solution_index)
    end
  end
end