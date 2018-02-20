require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet_array = (("A".."Z").to_a)
    @letters = []
    10.times do
      @letters << alphabet_array.sample
    end

  end

  def score

    @word = params[:word]
    @letters = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialized_file = open(url).read
    word_hash = JSON.parse(serialized_file)
    # ()
    if word_hash["found"] && word_from_grid?
      @message = "Congratulations your score is #{word_hash["length"]}"
    elsif word_from_grid?
      @message = "Sorry that word is not legitimate"
    else
      @message = "Sorry some letters were not from the grid"
    end

  end

  private

  def word_from_grid?
    test_array = (@word.upcase.split("") - @letters.split(" "))
    test_array.empty?
  end

end
