require_relative './song_library.rb'
require 'pry'

def list_artist(artist, album_hash)
   artist_list = "\n-------------------------\n #{artist}:\n-------------------------"
   album_hash[:albums].each do |album_name, songs_hash|
    #  binding.pry
     artist_list += "\n#{album_name}:\n\t"
     artist_list += songs_hash[:songs].join("\n\t")
   end
   artist_list
end

def list_library
  lib = full_library
  lib.each do |artist, album_hash|
    puts list_artist(artist, album_hash)
  end
end

def parse_command(command)
  parse_artist(command, full_library) || play_song(command, full_library) || not_found(command)
end

# Searches for song by artist
def parse_artist(command, lib)
  cmd = command.capitalize
  parsed = false
  if lib.has_key?(cmd)
    puts list_artist(command, lib[cmd])
    parsed = false
  else
    lib.each do |artist, hash|
      if command.downcase == artist.to_s.gsub("_"," ").downcase
        puts list_artist(artist, lib)
        parsed = true
        break
      end
    end
  end
  parsed
end

def play_song(command, lib)
  lib.each do |artist, hash|
    hash.each do |album_name, albums_hash|
      albums_hash.each do |album, songs_hash|
        songs_hash.each do |key, songs_array|
          songs_array.each do |song|
            if song.downcase == command.downcase
            puts "Now Playing: #{artist[command]}: #{album} - #{song}\n\n"
            return true
          end
        end
      end
    end
  end
  false
end

def not_found(command)
  puts "I did not understand '#{command}'!\n\n"
  true
end
end

def jukebox(command)
  if command.downcase == "list"
    # binding.pry
    list_library
  else
    # binding.pry
    parse_command(command)
  end
end

# Write a begin/ rescue wit pry to handle erros, and see where the issue is at
# use .nil? method to check what is nil and where
# check a method if something is nil
