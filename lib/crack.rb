require './lib/encryptor'
require './lib/offset_generator'

class Crack
  attr_reader :date, :key

  def initialize(date)
    @encryptor = Encryptor.new(key = nil, date)
    @key = nil
    @date = date
  end

  def standard_epilogue
    "..end.."
  end

  def crack_rotations(string)
    characters = @encryptor.characters
    rotations = zip_characters(string).map.with_index do |char, index|
      characters.index(char[1]) - characters.index(char[0])
    end
    adjusted_rotations(string, rotations)
  end

  def zip_characters(string)
    standard_ending = standard_epilogue[-4..-1].reverse.chars
    encrypted_ending = string[-4..-1].reverse.chars
    zipped_chars = standard_ending.zip(encrypted_ending)
  end

  def adjusted_rotations(string, rotations)
    absolute_rotations = rotations.map! do |rotation|
      rotation > 0 ? rotation : (88 + rotation)
    end
    absolute_rotations.rotate(string.length % 4).reverse
  end

  def crack_string(string)
    rotations = crack_rotations(string)
    decrypted_text = string.chars.map.with_index do |char, index|
      @encryptor.decrypt_letter(char, rotations[index % 4])
    end.join
  end

  def calculate_key(string)
    rotations = crack_rotations(string)
    zipped_array = rotations.zip(build_date_offsets)
    key_array = zipped_array.map { |item|  item[0] - item[1] }
    key_array = key_array.map { |item|  item > 10 ? item : item + 88 }
    build_calculated_key_string(key_array)
  end

  def build_date_offsets
    date = OffsetGenerator.new(@date)
    offsets = date.build_offsets
  end

  def build_calculated_key_string(key_array)
    adjusted = key_array.map { |num|  num.to_s.rjust(2, '0')}
    key_last_char = adjusted[-1][-1]
    key_four_char = adjusted.map { |num|  num[0] }.join
    @key = key_four_char + key_last_char
  end
end
