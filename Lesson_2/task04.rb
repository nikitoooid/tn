hash = Hash.new

('a'..'z').to_a.each_with_index { |letter, i| hash[letter.to_sym] = i + 1 }

hash.select!{ |letter| [:a,:e,:i,:o,:u].include? letter }