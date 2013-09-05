class HomeController < ApplicationController
  def index
    
  end
  
  def get_words
    predicted_word = PredictionWord.find_by_t_word(params[:word].split(" "))
    unless predicted_word.blank?
      @words = predicted_word.get_predicted_words
    end
  end
end
