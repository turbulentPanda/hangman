require_relative 'hangman.rb'
require_relative 'player.rb'

game = Hangman.new
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
