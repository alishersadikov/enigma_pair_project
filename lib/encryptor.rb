require './lib/key_generator'
require './lib/offset_generator'

class Encryptor
  attr_accessor :key, :date

  def initialize(key = nil, date = nil)
    @key = key
    @date = date
  end

  def characters
    characters = (' '..'z').to_a
    characters.delete_at(2)
    characters.delete_at(6)
    characters.delete_at(58)
    characters
  end

  def rotated_characters(rotation)
    characters.rotate(rotation)
  end

  def cipher(rotation)
    Hash[characters.zip(rotated_characters(rotation))]
  end

  def key_nil?
    @key == nil
  end

  def date_nil?
    @date == nil
  end

  def generate_key_array(key = nil)
    KeyGenerator.new(key).build_key_array
  end

  def generate_offsets_array(date = nil)
    OffsetGenerator.new(date).build_offsets
  end

  def build_rotations
    key_nil?  ? keys = generate_key_array : keys = generate_key_array(@key)
    date_nil? ? offsets = generate_offsets_array : offsets = generate_offsets_array(@date)
    rotations = keys.zip(offsets)
    rotations.map { |item|  item[0] + item[1] }
  end

  def encrypt_letter(letter, rotation)
    cipher_for_current_rotation = cipher(rotation)
    cipher_for_current_rotation[letter]
  end

  def encrypt_string(string)
    rotations = build_rotations
    encrypted_text = string.chars.map.with_index do |char, index|
      rotation = rotations[index % 4]
      encrypt_letter(char, rotation)
    end.join
  end

  def decrypt_letter(letter, rotation)
    rotation = (rotation - 88).abs
    cipher_for_current_rotation = cipher(rotation)
    cipher_for_current_rotation[letter]
  end

  def decrypt_string(string)
    rotations = build_rotations
    decrypted_text = string.chars.map.with_index do |char, index|
      rotation = rotations[index % 4]
      decrypt_letter(char, rotation)
    end.join
  end
end
