require_relative 'hangman.rb'
require_relative 'player.rb'

game = Hangman.new
player = Player.new

puts "A secret word has been chosen. Please enter your guesses, one letter at a time. "

until game.game_over?
  guess = player.guess_letter
  game.play_one_turn(guess)
end

puts game.get_game_results
