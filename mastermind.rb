require "./mastermind_match"

# answers can be a Regexp or an Array.
def prompt(question, answers)
  loop do
    print question
    response = gets.chop
    return response if answers.is_a?(Regexp) && response.match?(answers)
    return response if answers.is_a?(Array) && answers.include?(response)
    puts "Invalid input. Please try again"
  end
end

loop do
  puts "W E L C O M E   T O   M A S T E R M I N D"
  puts "\"Your middle school math teacher's favorite board game\""
  
  question = "Please enter the number of colors for this match (2-10): "
  number_of_colors = prompt(question, /\A([2-9]|10)\Z/).to_i
  question = "Please enter the number of turns you'd like to play (2-99): "
  number_of_turns = prompt(question, /\A([2-9]|[1-9][0-9])\Z/).to_i
                           
  match = MastermindMatch.new(number_of_colors, number_of_turns)
  
  loop do
    puts "TURN #{match.turns.length + 1}"
    puts "Possible colors: " + match.colors.join(", ")
    guess = []
    4.times do |i| 
      question = "Please enter color number #{i + 1}: "
      guess << prompt(question, match.colors)
    end
    
    match.take_turn(guess)
    puts match
    break unless match.game_state == :ongoing
  end
  
  puts "Congratulations! you win!" if match.game_state == :win
  puts "You lose :<" if match.game_state == :lose
  
  question = "Play again? (y/n): "
  break if prompt(question, /\A[yYnN]\Z/).downcase == "n"
end