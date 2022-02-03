class Hangman
  attr_accessor :secret_word, :turns_remaining, :correct_letters, :incorrect_letters

  def initialize
    self.secret_word = choose_secret_word
    self.turns_remaining = 6
    self.correct_letters = []
    self.incorrect_letters = []
  end

  private
  def choose_secret_word
    File.readlines('acceptable_hangman_words.txt').sample.strip
  end
end

game = Hangman.new
puts game.secret_word
puts game.secret_word.length