require "./mastermind_match"
require "./mastermind_ai"

class Mastermind
  def initialize
    puts "W E L C O M E   T O   M A S T E R M I N D"
    puts "\"Your middle school math teacher's favorite board game\""

    loop do
      question = "Please enter the number of colors for this match (2-10): "
      number_of_colors = prompt(question, /\A([2-9]|10)\Z/).to_i
      question = "Please enter the number of turns you'd like to play (2-99): "
      number_of_turns = prompt(question, /\A([2-9]|[1-9][0-9])\Z/).to_i
      question = "Human or AI match? "
      match_type = prompt(question, /\A(human|ai)\Z/i).downcase

      if match_type == "human"
        human_cli(number_of_colors, number_of_turns)
      elsif match_type == "ai"
        ai_cli(number_of_colors, number_of_turns)
      end
      
      question = "Play again? (y/n): "
      break if prompt(question, /\A[yn]\Z/i).downcase == "n"
    end
  end

  private

  def human_cli(number_of_colors, number_of_turns)
    match = MastermindMatch.new(number_of_colors, number_of_turns)

    loop do
      puts "TURN #{match.turns.length + 1}"
      guess = ask_for_colors(match.colors)
      match.take_turn(guess)
      puts match
      break unless match.game_state == :ongoing
    end
    
    puts "Congratulations! you win!" if match.game_state == :win
    puts "You lose :<" if match.game_state == :lose
  end

  def ai_cli(number_of_colors, number_of_turns)
    puts "Please put in the color combination you'd like the AI to guess"
    possible_colors = MastermindMatch.possible_colors(number_of_colors)
    solution = ask_for_colors(possible_colors)
    match = MastermindMatch.new(number_of_colors, number_of_turns, solution)
    ai = MastermindAI.new(match)
    puts match

    loop do
      puts ai.guess
      sleep(1)
      break unless match.game_state == :ongoing
    end

    puts "The computer found your code!" if match.game_state == :win
    puts "Congratulations! You beat the machine!" if match.game_state == :lose
  end

  def ask_for_colors(possible_colors)
    puts "Possible colors: " + possible_colors.join(", ")
    result = []
    4.times do |i| 
      question = "Please enter color number #{i + 1}: "
      result << prompt(question, possible_colors)
    end
    result
  end 
  
  # answers can be a Regexp or an Array
  def prompt(question, answers)
    loop do
      print question
      response = gets.chop
      return response if answers.is_a?(Regexp) && response.match(answers)
      return response if answers.is_a?(Array) && answers.include?(response)
      puts "Invalid input. Please try again"
    end
  end
end

Mastermind.new
