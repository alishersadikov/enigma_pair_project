require_relative "key_generator"
require_relative "offset_generator"

class Encryptor
  attr_accessor :key, :date

  def initialize(key = nil, date = nil)
    @key = key
    @date = date
  end

  def characters
    (' '..'z').to_a
  end

  def rotated_characters(rotation)
    characters.rotate(rotation)
  end

  def cipher(rotation)
    Hash[characters.zip(rotated_characters(rotation)) ]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_current_rotation = cipher(rotation)
    cipher_for_current_rotation[letter]
  end

  def decrypt_letter(letter, rotation)
    rotation = (rotation - 91).abs
    cipher_for_current_rotation = cipher(rotation)
    cipher_for_current_rotation[letter]
  end

  def build_rotations
    @key == nil ? keys = KeyGenerator.new.build_key_array : keys = KeyGenerator.new(@key).build_key_array
    @date == nil ? offsets = OffsetGenerator.new.build_offsets : offsets = OffsetGenerator.new(@date).build_offsets
    rotations = keys.zip(offsets)
    rotations.map { |item|  item[0] + item[1] }
  end

  def encrypt_string(string)
    rotations = build_rotations
    encrypted_text = string.chars.map.with_index do |char, index|
      rotation = rotations[index % 4]
      encrypt_letter(char, rotation)
    end
    encrypted_text.join
  end

  def decrypt_string(string)
    rotations = build_rotations
    decrypted_text = string.chars.map.with_index do |char, index|
      rotation = rotations[index % 4]
      decrypt_letter(char, rotation)
    # require 'pry';binding.pry
    end
    decrypted_text.join
  end

end

# characters = (' '..'z').to_a
# se = standard_epilogue = '.. end ..'
# ee = encrypted_epilogue = '9*lzy`lC9'
# key = "08715"
# date = "082916"
#
# counter = 0
# rotations = []
# while counter != 4
#   rotations << (characters.index(ee[counter]) - characters.index(se[counter]))
#   counter += 1
# end
#
# puts rotations.inspect
#
# rotations.map! do |rotation|
#   rotation > 0 ? rotation = rotation : rotation = (91 + rotation)
# end
# puts rotations.inspect



  # def crack(string)
  #   sub_string = string[-9..-1]
  #   array = characters.count.times.collect do |attempt|
  #     encrypt_letter(string[-1], attempt)
  #     counter
  #   end


    # puts rotation_1 = 91 - characters.index(string[-1]) - characters.index(".")
    # puts rotation_2 = 91 - characters.index(string[-2]) - characters.index(".")
    # puts rotation_3 = 91 - characters.index(string[-3]) - characters.index(" ")
    # puts rotation_4 = 91 - characters.index(string[-4]) - characters.index("d")
    # puts rotation_5 = 91 - characters.index(string[-5]) - characters.index("n")
    # puts rotation_6 = 91 - characters.index(string[-6]) - characters.index("e")
    # puts rotation_7 = 91 - characters.index(string[-7]) - characters.index(" ")
    # puts rotation_8 = 91 - characters.index(string[-8]) - characters.index(".")
    # puts rotation_9 = 91 - characters.index(string[-9]) - characters.index(".")
    # rotations = [rotation_9, rotation_8, rotation_7, rotation_6, rotation_5, rotation_4, rotation_3, rotation_2, rotation_1]
