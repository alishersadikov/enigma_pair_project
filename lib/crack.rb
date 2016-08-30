  class Crack
    attr_reader :date, :key

    def initialize(date = 0)
      @encryptor = Encryptor.new(key = nil, date)
      @key = nil
      @date = date
    end

    def calculate_key(string)
      date = OffsetGenerator.new(@date)
      offsets = date.build_offsets
      rotations = crack_rotations(string)
      zipped_array = rotations.zip(offsets)
      key_array = zipped_array.map do |item|
        item[0] - item[1]
      end
      @key =key_array.map  { |sub_key| sub_key.to_s.rjust(2, '0')[0]}.join + key_array[-1].to_s[1]
    end

    def crack_string(string)
      rotations = crack_rotations(string)
      decrypted_text = string.chars.map.with_index do |char, index|
        @encryptor.decrypt_letter(char, rotations[index % 4])
      end
      decrypted_text.join
    end



    def crack_rotations(string)
      characters = @encryptor.characters
      rotations = zip_characters(string).map.with_index do |char, index|
        characters.index(char[1]) - characters.index(char[0])
      end
      adjusted_rotations(string, rotations)

    end

    def zip_characters(string)
      standard_epilogue = 'd ..'.reverse.chars
      encrypted_epilogue = string[-4..-1].reverse.chars
      zipped_chars = standard_epilogue.zip(encrypted_epilogue)
    end

    def adjusted_rotations(string, rotations)
      absolute_rotations = rotations.map! do |rotation|
        rotation > 0 ? rotation = rotation : rotation = (91 + rotation)
      end
      absolute_rotations.rotate(string.length % 4).reverse
      # require 'pry'; binding.pry
    end

    end
  # string = ''
  # crack = Crack.new("111111")
  # puts crack.crack_rotations(string).inspect
  # puts crack.crack_string(string)
  # puts crack.date
  # puts crack.calculate_key(string).inspect
  # puts crack.key.inspect
