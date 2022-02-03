class Hangman
  attr_accessor :secret_word, :turns_remaining, :correct_letters, :incorrect_letters

  def initialize
    self.secret_word = choose_secret_word
    self.turns_remaining = 6
    self.correct_letters = []
    self.incorrect_letters = []
  end

  def display_word(secret_word_string, correct_letters_array)
    letter_array = Array.new(secret_word_string.length, '___')
    secret_word_string.each_char.with_index do |letter, index| 
      letter_array[index] = letter if correct_letters_array.include?(letter)
    end
    letter_array.join(" ")
  end

  private
  def choose_secret_word
    File.readlines('acceptable_hangman_words.txt').sample.strip
  end

end

game = Hangman.new
p game.display_word("christopher", ['c', 'h', 'r', 'p'])

