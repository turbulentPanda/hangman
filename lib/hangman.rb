require 'colorize'
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

  def get_game_status
    "#{get_guess_so_far}\n\n"\
    "Attempts remaining: #{self.turns_remaining}\n\n"\
    "Guessed letters: #{self.guessed_letters.join(" ")}\n\n"
  end

  def play_one_turn(guess)
    evaluate_guess(guess)
    puts get_game_status
  end

  def get_game_results
    correct_guess? ? "Congratulations! You guessed the secret word!\n\n" : "You lost! The secret word was \"#{self.secret_word}\"\n\n"
  end

  def save_game
    puts "Enter a name for your game: "
    game_name = gets.chomp
    file_path = "saved_games/#{game_name}.txt"
    if File.exist?(file_path)
      puts "That game already exists. Enter a new name or enter 'YES' to overwrite."
      new_name = gets.chomp
      unless new_name == 'YES'
        file_path = "saved_games/#{new_name}.txt"
      end
    end
    File.open(file_path, "w+").puts(serialize_current_game)
  end

  def self.load_game
    puts "\nThese are the currently saved games: \n\n"
    self.display_saved_games
    puts "\nPlease enter the name of the game you wish to load: \n\n"
    game_name = gets.chomp
    file_path = "saved_games/#{game_name}.txt"
    if File.exists?(file_path)
      deserialize_game(file_path)
    else
      nil
    end
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
      guessed_letters << guess.colorize(:green)
    else
      decrement_turns_remaining
      guessed_letters << guess.colorize(:red)
    end
  end

  def correct_guess?
    self.secret_word.split("").all? { |letter| self.correct_letters.include?(letter) }
  end

  def get_guess_so_far
    letter_array = Array.new(self.secret_word.length, '___')
    self.secret_word.each_char.with_index do |letter, index| 
      letter_array[index] = letter if self.correct_letters.include?(letter)
    end
    letter_array.join(" ")
  end

  def serialize_current_game
    YAML.dump({
      secret_word: secret_word,
      turns_remaining: turns_remaining,
      correct_letters: correct_letters,
      guessed_letters: guessed_letters
    })
  end

  def self.deserialize_game(serialized_game_file_path)
    serialized_game = File.open(serialized_game_file_path)
    saved_data = YAML.load serialized_game
    self.new(saved_data[:secret_word], saved_data[:turns_remaining], saved_data[:correct_letters], saved_data[:guessed_letters])
  end

  def self.display_saved_games
    Dir.glob('saved_games/*').each do |game|
      puts File.basename(game, ".txt")
    end
  end

end