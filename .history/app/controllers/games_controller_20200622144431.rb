require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    consonants = [*('A'..'Z')] - %w[A E I O U]
    vowels = %w[A E I O U]
    @letters = []
    6.times { @letters << consonants.sample }
    3.times { @letters << vowels.sample }
    @letters.shuffle
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    @from_grid = (@word.upcase.split('') - @letters).empty?

  end

  def check_dict(word)
    data = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
    data["found"]
end
