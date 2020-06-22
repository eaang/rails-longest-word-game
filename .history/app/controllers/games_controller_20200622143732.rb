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
    @word = params[:word].upcase.split('')
    letters = params[:letters].split(' ')
    @from_grid = (word - letters).empty?
  end
end
