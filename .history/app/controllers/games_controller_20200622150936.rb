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
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    @from_grid = (@word.split('') - @letters).empty?
    @valid_word = check_dict(@word)
    @score = compute_score(@word)
    if session[:total_score].nil?
      session[:total_score] = @score
    else
      session[:total_score] += @score
    end
  end

  def check_dict(word)
    data = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
    data['found']
  end

  def compute_score(word)
    values = {
      /[AEIOULNRST]/ => 1, /[DG]/ => 2, /[BCMP]/ => 3,
      /[FHVWY]/ => 4, /[K]/ => 5, /[JX]/ => 8, /[QZ]/ => 10
    }
    score = 0
    values.each do |letters, value|
      score += (word.scan(letters).count * value)
    end
    score
  end
end
