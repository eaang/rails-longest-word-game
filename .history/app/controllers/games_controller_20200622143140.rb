class GamesController < ApplicationController
  def new
    consonants = [*('A'..'Z')] - ["A", "E", "I", "O", "U"]
    vowels = ["A", "E", "I", "O", "U"]
    @letters = []
    6.times { @letters << consonants.sample }
    3.times { @letters << vowels.sample }
    @letters.shuffle
  end

  def score
    @word = params[:word].upcase.split("")
  end
end
