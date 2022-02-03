class Hangman
  attr_accessor :secret_word, :turns_remaining, :correct_letters, :incorrect_letters

  def initialize
    self.secret_word = choose_secret_word
    self.turns_remaining = 6
    self.correct_letters = []
    self.incorrect_letters = []
  end

  def evaluate_guess(secret_word, guess)
    if secret_word.include?(guess) && !self.correct_letters.include?(guess)
      self.correct_letters << guess
    end
  end

  def display_word
    letter_array = Array.new(secret_word_string.length, '___')
    self.secret_word.each_char.with_index do |letter, index| 
      letter_array[index] = letter if self.correct_letters.include?(letter)
    end
    letter_array.join(" ")
  end

  def decrement_turns_remaining
    self.turns_remaining -= 1
  end

  def play_one_turn(secret_word, guess)
    evaluate_guess(secret_word, guess)
    display_word
    decrement_turns_remaining
  end

  def game_over?
    correct_guess? || self.turns_remaining == 0
  end


  private
  def choose_secret_word
    File.readlines('acceptable_hangman_words.txt').sample.strip
  end

  def correct_guess?
    self.secret_word.split("").all? { |letter| self.correct_letters.include?(letter) }
  end


end

