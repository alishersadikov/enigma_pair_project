class Encryptor

  def initialize
    @key = KeyGenerator.new
    @offset = OffsetGenerator.new
  end

  def characters
    (' '..'z').to_a
  end

  def rotated_characters(rotation)
    characters.rotate(rotation)
  end

  def cipher(rotation)
    Hash[characters.zip(rotated_characters(rotation))]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_current_rotation = cipher(rotation)
    cipher_for_current_rotation[letter]
  end

  def build_rotations
    keys = @key.build_key_array
    offsets = @offset.build_offsets
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

end