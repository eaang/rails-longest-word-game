class GamesController < ApplicationController
  def new
    alphabet = [*('A'..'Z')]
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    raise
  end
end
