require './lib/encryptor'
require './lib/offset_generator'

class Crack
  attr_reader :date, :key

  def initialize(date)
    @encryptor = Encryptor.new(key = nil, date)
    @key = nil
    @date = date
  end

  def crack_rotations(string)
    characters = @encryptor.characters
    rotations = zip_characters(string).map.with_index do |char, index|
      characters.index(char[1]) - characters.index(char[0])
    end
    adjusted_rotations(string, rotations)
  end

  def standard_epilogue
    "..end.."
  end

  def zip_characters(string)
    standard_ending = standard_epilogue[-4..-1].reverse.chars
    encrypted_ending = string[-4..-1].reverse.chars
    zipped_chars = standard_ending.zip(encrypted_ending)
  end

  def adjusted_rotations(string, rotations)
    absolute_rotations = rotations.map! do |rotation|
      rotation > 0 ? rotation = rotation : rotation = (91 + rotation)
    end
    absolute_rotations.rotate(string.length % 4).reverse
    # require 'pry'; binding.pry
  end

  def crack_string(string)
    rotations = crack_rotations(string)
    decrypted_text = string.chars.map.with_index do |char, index|
      @encryptor.decrypt_letter(char, rotations[index % 4])
    end
    decrypted_text.join
  end

  def calculate_key(string)
    rotations = crack_rotations(string)
    zipped_array = rotations.zip(build_date_offsets)
    key_array = zipped_array.map { |item|  item[0] - item[1] }
    build_calculated_key_string(key_array)
  end

  def build_date_offsets
    date = OffsetGenerator.new(@date)
    offsets = date.build_offsets
  end

  def build_calculated_key_string(key_array)
    key_four_char = key_array.map do |num|
      num.to_s.rjust(2, '0')[0]
    end
    key_last_char = key_array[-1].to_s[1]
    @key = key_four_char.join + key_last_char
  end
end
