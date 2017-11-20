require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = Array.new(10){[*"A".."Z"].sample}
  end


  def is_english?(proposal)
    url = 'https://wagon-dictionary.herokuapp.com/#{proposal}'
    document = open(url).read
    valid = JSON.parse(document)
    return valid["found"]
  end

  def is_in_grid?(proposal, grid)
    if proposal.upcase.split("").each do |letter|
            proposal.upcase.count(letter) > grid.count(letter)
      end
      return false
    end
  end

  def score
    @proposal = params[:word]
    @letters = params[:letters].split("")
    if !is_english?(@proposal)
      return @message = "phrase d'erreur"
    else
      if !is_in_grid?(@proposal, @letters)
        return @message = "efzef"
      else
        @message = "great!"
      end
    end
  end
end
