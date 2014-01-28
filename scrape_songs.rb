
require 'json'

$WAY_BACK_MACHINE = true

def curl url, file_name
  command = "curl --user-agent 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36' --location #{url} > #{file_name}"
  p command
  `#{command}`
end

def form_url song_url
  url = ($WAY_BACK_MACHINE ? "http://web.archive.org/web/20130625022802/" : "")
  url += "http://www.azlyrics.com/lyrics/" + song_url
  url
end

def form_file_name file_name, song_name
  file_name + "_dir/" + song_name.gsub(/[^a-zA-Z0-9]/, "_")
end

def fetch_all_songs file_name
  f = File.readlines(file_name)
  songs_list = JSON.parse f[0]
  #songs_list.take(5).each do |song|
  songs_list.each do |song|
    song_name = song["s"]; song_url = song["h"]
    curl(form_url(song_url), form_file_name(file_name, song_name))
    sleep(3)
  end
end

fetch_all_songs "dylan"
fetch_all_songs "beatles"

