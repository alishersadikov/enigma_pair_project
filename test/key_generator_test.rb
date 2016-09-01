require './test/test_helper'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test

  def test_it_accepts_key_when_it_passed_in
    key = KeyGenerator.new("12345")
    assert_equal "12345", key.digits
  end

  def test_it_generates_five_digit_string_by_default
    key = KeyGenerator.new
    assert_equal 5, key.generate_random_digits.size
  end

  def test_randomness_of_generated_strings
    key1 = KeyGenerator.new
    key2 = KeyGenerator.new
    expected = key1.generate_random_digits
    actual = key2.generate_random_digits
    refute_equal expected, actual
  end

  def test_it_builds_key_array
    key = KeyGenerator.new
    assert_instance_of Array, key.build_key_array
    assert_equal 4, key.build_key_array.size
  end

  def test_it_also_builds_the_key_array_when_key_is_passed_in
    key = KeyGenerator.new("12345")
    assert_equal [12, 23, 34, 45], key.build_key_array
  end

  def test_it_grabs_the_first_five_digits_if_given_key_too_long
    key1 = KeyGenerator.new("4321234567")
    assert_equal [43, 32, 21, 12], key1.build_key_array
  end 
end
