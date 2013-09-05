class PredictionWord < ActiveRecord::Base
  serialize :t_prediction_words, Hash

  def get_predicted_words
    predicted_words = self.t_prediction_words
    return predicted_words.first[1].sort_by{|k,v| v}.reverse.collect{|a| a[0]} unless predicted_words.blank?
  end
end
