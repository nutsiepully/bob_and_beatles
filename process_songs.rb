
require('nokogiri')

def get_words_for_song artist, song
  doc = Nokogiri::HTML(open(artist + "_dir/" + song))
  text = doc.css('div#main :nth-child(14)').text.strip

  puts "empty - " + song if text.empty?

  words = text.split
  words
end

def type_token token
  $type_counter << ($word_map.include?(token) ? $type_counter.last : $type_counter.last + 1)
end

def map_word word
  if !$word_map.include?(word)
    $word_map[word] = 1
    return
  end

  $word_map[word] += 1
end

def dump_hash_to_file file_name, hash
  File.open(file_name, "w") do |f|
    hash.each do |elem|
      f << elem[0] << " " << elem[1] << "\n"
    end
  end
end

def dump_array_to_file file_name, arr
  File.open(file_name, "w") do |f|
    arr.each do |elem|
      f << elem << "\n"
    end
  end
end

def process artist
  $word_map = {}
  $type_counter = [0]

  files = Dir.entries(artist + "_dir")
  #files.take(3).each do |file|
  files.each do |file|
    next if (file == "." || file == "..")
    words = get_words_for_song(artist, file)
    words.each do |word|
      word.strip!; word.downcase!
      next if (/[^a-zA-Z]/ =~ word) != nil
      type_token(word)
      map_word(word)
    end
  end

  $type_counter.shift
  $word_map = $word_map.sort_by { |k, v| v }.reverse

  dump_hash_to_file(artist + "_word_map", $word_map)
  dump_array_to_file(artist + "_type_list", $type_counter)
end

process "dylan"
process "beatles"

