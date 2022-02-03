require 'yaml'
class Hangman
  attr_accessor :secret_word, :turns_remaining, :correct_letters, :guessed_letters

  def initialize(secret_word = choose_secret_word, turns_remaining = 6, correct_letters = [], guessed_letters = [])
    self.secret_word = secret_word
    self.turns_remaining = turns_remaining
    self.correct_letters = correct_letters
    self.guessed_letters = guessed_letters
  end

  def game_over?
    correct_guess? || self.turns_remaining == 0
  end

  def play_one_turn(guess)
    evaluate_guess(guess)
    puts display_word
    puts "Turns remaining: #{self.turns_remaining}"
    puts "Guessed letters: #{self.guessed_letters.join(" ")}"
  end

  def get_game_results
    if correct_guess?
      "Congratulations! You guessed the secret word!"
    else
      "Sorry! Better luck next time. The secret word was \"#{self.secret_word}\""
    end
  end

  def serialize
    YAML.dump({
      secret_word: self.secret_word,
      turns_remaining: self.turns_remaining,
      correct_letters: self.correct_letters,
      guessed_letters: self.guessed_letters
    })
  end

  def self.deserialize(serialized_content)
    deserialized_data = YAML.load serialized_content
    self.new(saved_data[])
  end

  private

  def choose_secret_word
    File.readlines('acceptable_hangman_words.txt').sample.strip
  end

  def decrement_turns_remaining
    self.turns_remaining -= 1
  end

  def evaluate_guess(guess)
    if self.secret_word.include?(guess) && !self.correct_letters.include?(guess)
      self.correct_letters << guess
    elsif self.correct_letters.include?(guess)
      decrement_turns_remaining
    else
      decrement_turns_remaining
    end
    guessed_letters << guess
  end

  def display_word
    letter_array = Array.new(self.secret_word.length, '___')
    self.secret_word.each_char.with_index do |letter, index| 
      letter_array[index] = letter if self.correct_letters.include?(letter)
    end
    letter_array.join(" ")
  end

  def correct_guess?
    self.secret_word.split("").all? { |letter| self.correct_letters.include?(letter) }
  end

end