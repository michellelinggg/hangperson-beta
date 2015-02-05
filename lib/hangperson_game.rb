class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :guesses, :wrong_guesses, :word

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def initialize(new_word)
  	@word = new_word
  	@guesses = ""
  	@wrong_guesses = ""
  end

  def guess(new_guess)
  	if new_guess && new_guess.match(/^[[:alpha:]]$/)
      new_guess = new_guess.downcase
	  	if @guesses.include?(new_guess) || @wrong_guesses.include?(new_guess)
	  		return false
	  	end
	  	if @word.include?(new_guess)
	  		@guesses = @guesses + new_guess
	  	else
	  		@wrong_guesses = @wrong_guesses + new_guess
	  	end
	  	return true
  	else
  		raise ArgumentError.new("Must guess a letter.")
  	end
  end

  def check_win_or_lose
  	if (@guesses.length > 1) && (@word.tr(@guesses, "") == "")
  		return :win 
  	elsif @wrong_guesses.length == 7
  		return :lose 
  	else
  		return :play
  	end
  end

  def word_with_guesses
  	if @guesses.length > 0
  		return @word.tr("^#{@guesses}", "-")
  	else
  		return @word.tr(@word, "-")
  	end
  end

end
