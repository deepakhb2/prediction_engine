class ChangeTWordTypeInPredictionWords < ActiveRecord::Migration
  def self.up
    change_column :prediction_words, :t_word, "varbinary(255)"
  end

  def self.down
    change_column :prediction_words, :t_word, :string
  end
end
