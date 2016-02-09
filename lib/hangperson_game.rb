class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    @num_incorrect_guesses = 0
  end

  def letter?(input)
    input =~ /[A-Za-z]/
  end

  def guess(letter)
    if  (letter.nil?) || (letter.empty?) || !(letter?(letter))
      raise ArgumentError
    end
    letter = letter.downcase
    if (@guesses.include? letter) || (@wrong_guesses.include? letter)
      return false
    end
    if @word.include? letter
        @guesses << letter
        @word_with_guesses = word_with_guesses
    else
        @wrong_guesses << letter
        @num_incorrect_guesses += 1
    end
    check_win_or_lose
  end

  def word_with_guesses
    @word_with_guesses = ''
    @word.chars { |char|
      if @guesses.include? char
        @word_with_guesses += char
      else
        @word_with_guesses += '-'
      end
    }
    return @word_with_guesses
  end

  def check_win_or_lose
    if @num_incorrect_guesses == 7
      return :lose
    elsif @word_with_guesses == word
      return :win
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end