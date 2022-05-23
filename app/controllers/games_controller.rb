require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    array = []
    10.times do
      array << (('A'..'Z')).to_a.sample
    end
    @letters = array
  end

  def score
    @result =
      if included?(params[:word].upcase, new)
        if english_word?(params[:word])
          "Congratulations! #{params[:word]} is a valid English word!"
        else
          "Sorry but #{params[:word]} does not seem to be a valid English word..."
        end
      else
        "Sorry but #{params[:word]} can't be built out of the grid..."
      end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |c| grid.include? c }
  end
end
