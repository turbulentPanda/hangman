# To make the game more interesting, this Hangman game only allows words between 5 and 12 characters
# This filters the words in dictionary.txt and creates a new acceptable_handman_words.txt 
# in which all of the words are between this length

acceptable_hangman_words = File.open('acceptable_hangman_words.txt', 'w+')
File.open('dictionary.txt').readlines.each do |word|
  acceptable_hangman_words.write(word) if word.strip.length.between?(5, 12)
end
acceptable_hangman_words.close
