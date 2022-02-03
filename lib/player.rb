require 'colorize'
class Player
  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'
  def initialize
  end

  def guess_letter
    puts "Please enter a letter: "
    letter = gets.chomp
    until ALPHABET.include?(letter.downcase) && letter.length == 1
      puts "Sorry, that is an invalid input. Please enter a single letter: ".colorize(:red)
      letter = gets.chomp
    end
    letter.downcase 
  end
end