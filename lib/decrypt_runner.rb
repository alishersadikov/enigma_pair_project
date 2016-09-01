
require "./lib/encryptor"
require "./lib/key_generator"
require "./lib/offset_generator"
require 'date'

class Runner

  input_file = ARGV[0]
  output_file = ARGV[1]
  key = ARGV[2]
  date = ARGV[3]

  keys = KeyGenerator.new(key)
  offset = OffsetGenerator.new(date)
  encryptor = Encryptor.new(key)

  string = File.read(input_file).chomp

  decrypted_text = encryptor.decrypt_string(string)
  File.write(output_file, decrypted_text)

  puts "Created '#{output_file}' with the #{key} and date #{date}"

end
