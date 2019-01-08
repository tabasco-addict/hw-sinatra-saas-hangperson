class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word_with_guesses()
    show_word = word.gsub(/[^#{guesses}=]/,'-')
    show_word
  end
  
  def check_win_or_lose()
    if word_with_guesses.include?('-') && wrong_guesses.size == 7
      return :lose
    elsif not word_with_guesses.include?('-')
      return :win
    end
    :play
  end
  
  def guess(guess)
    
    #regex in this line is not i18n-friendly
    if guess == nil || guess.empty? || guess =~ /[^a-zA-Z]/
      raise ArgumentError
    end
    
    @guess = guess.downcase!
    
    if guess.length == 1
      if !guesses.include?(guess) && !wrong_guesses.include?(guess)
        if word.include?(guess)
            guesses << guess
            word_with_guesses
            #num_guesses += 1
            check_win_or_lose()
        else wrong_guesses << guess
          #num_guesses += 1
          check_win_or_lose()
        end
      else 
        puts "already been guessed!"
        return false
      end
    else
      puts "guesses must be one letter"
    end
    
  end

  # Get a word from remote "random word" service  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  
end
