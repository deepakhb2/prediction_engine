class CreatePredictionWords < ActiveRecord::Migration
  def self.up
    create_table :prediction_words do |t|
      t.string :t_word
      t.text :t_prediction_words
      t.timestamps
    end
  end

  def self.down
    drop_table :prediction_words
  end
end
