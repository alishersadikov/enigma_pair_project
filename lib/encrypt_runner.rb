
require "pry"
require "./lib/encryptor"
require "./lib/key_generator"
require "./lib/offset_generator"
require 'date'


class Runner

#   $ ruby ./lib/encrypt.rb message.txt encrypted.txt
# Created 'encrypted.txt' with the key 82648 and date 030415

#   $ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030415
# Created 'decrypted.txt' with the key 82648 and date 030415

  input_file = ARGV[0]
  output_file = ARGV[1]
  key = ARGV[2]

  key = KeyGenerator.new
  offset = OffsetGenerator.new

  random_key = key.generate_random_digits
  encryptor = Encryptor.new(random_key)

  string = File.read(input_file).chomp

  encrypted_text = encryptor.encrypt_string(string)
  File.write(output_file, encrypted_text)

  puts "Created '#{output_file}' with the #{random_key} and date #{Time.now.strftime("%m%d%y")}"

end
