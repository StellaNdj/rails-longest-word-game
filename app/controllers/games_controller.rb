class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    letters = ('a'..'z').to_a
    @letters = letters.sample(10).join(" ")
    @word = params[:word]
  end

  def score
    @word = params[:word]
    @arr = params[:letters]
    @word_arr = @word.chars
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(url).read
    @data = JSON.parse(response)

    @exist = @data['found']
    @length = @data['length']

    if @exist == true
      if @word_arr.all? { |letter| @arr.include?(letter) }
        @word_arr.each { |letter| @arr.delete(letter) }
        @results = "#{@word} is a valid English word and part of the grid"
      else
        @results = "#{@word} is a valid English word but not part of the grid"
      end
    else
      @results = "#{@word} is not a valid English word"
    end
  end
end
