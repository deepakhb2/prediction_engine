namespace(:read_file) do
  #require "#{Rails.root}/app/models/prediction_word.rb"
  require 'config/environment'
  task :get_words, :path do |t, args|
    puts args
    file = File.new(args[:path], "r")
    while (line = file.gets)
      words = line.split(" ")
      words.each_with_index do |word, index|
        puts index
        remaining_words = words[index+1...index+2]
        puts remaining_words
        word1 = word.gsub(/[^a-zA-Z ]/,'')
        puts get_next_words(remaining_words).sort.inspect
        prediction_word = PredictionWord.find_by_t_word(word1)
        puts prediction_word.inspect
        if prediction_word.blank?
          puts "inside if"
          prediction_word = PredictionWord.new
          puts word1+'asfdsdfsd'
          prediction_word.t_word = word1
          puts get_next_words(remaining_words)
          next_words = get_next_words(remaining_words)
          prediction_word.t_prediction_words = next_words
          puts prediction_word.inspect
          prediction_word.save
        else
          next_words = get_next_words(remaining_words, prediction_word.t_prediction_words)
          prediction_word.t_prediction_words = next_words
          prediction_word.save
        end
      end
    end
    file.close
  end

  def get_next_words(words, next_words = nil)
    next_words = Hash.new if next_words.blank?
    words.each_with_index do |word1, index|
      word = word1.gsub(/[^a-zA-Z ]/,'')
      if next_words[index].blank?
        word_counts = Hash.new
        word_counts[word] = 1
        next_words[index]= word_counts
      else
        word_counts = next_words[index]
        if word_counts[word].blank?
          word_counts[word] = 1
          next_words[index] = word_counts
        else
          word_counts[word] = word_counts[word]+1
          next_words[index] = word_counts
        end
      end
    end
    return next_words
  end

end