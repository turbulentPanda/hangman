class Hangman
  attr_accessor :secret_word, :turns_remaining, :correct_letters, :incorrect_letters

  def initialize
    self.turns_remaining = 6
    self.correct_letters = []
    self.incorrect_letters = []
  end
end