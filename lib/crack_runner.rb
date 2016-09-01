require './lib/encryptor'
require  './lib/crack'


# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 030415
# Created 'cracked.txt' with the cracked key 82648 and date 030415

class CrackRunner

  encrypted_file = ARGV[0]
  cracked_file = ARGV[1]
  date = ARGV[2]

  crack = Crack.new(date)

  encrypted_text = File.read(encrypted_file).chomp

  cracked_text = crack.crack_string(encrypted_text)
  File.write(cracked_file,  cracked_text)

  key = crack.calculate_key(encrypted_text)

  puts "Created '#{cracked_file}' with #{key} and date #{crack.date}"
end
