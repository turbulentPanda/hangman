require_relative 'hangman.rb'
require_relative 'player.rb'

puts 'Welcome to Hangman!'
puts '1) To play a new game, enter 1.'
puts '2) To load a previously saved game, enter 2'

new_game_or_load = gets.chomp.to_i

if new_game_or_load == 1
  game = Hangman.new
else
  game = Hangman.load_game
  if game == nil
    puts "That game does not exist. Starting a new game now."
    game = Hangman.new
  end
  puts game.get_game_status
end

player = Player.new

puts "A secret word has been chosen. Please enter your guesses, one letter at a time. "
puts "At any point, you may enter 'save' (without quotes) to save your progress and quit"

until game.game_over?
  guess = player.guess_letter
  if guess == 'save'
    game.save_game
    exit
  else
    game.play_one_turn(guess)
  end
end

puts game.get_game_results
