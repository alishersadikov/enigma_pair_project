 class KeyGenerator
   attr_reader :digits

   def initialize(digits = 0)
     @digits = digits
   end

   def generate_random_digits
     @digits != 0 ? @digits : @digits = (0..9).to_a.sample(5).join.to_s
  end

  def build_key_array
    generate_random_digits
    key = []
    key << @digits[0..1] << @digits[1..2] << @digits[2..3] << @digits[3..4]
    key.map { |digit| digit.to_i }
  end
 end
