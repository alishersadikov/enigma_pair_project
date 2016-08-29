require './test/test_helper'
require './lib/offset_generator'
require './lib/key_generator'
require './lib/encryptor'

class EncryptorTest < Minitest::Test

  def encryptor
    ::Encryptor.new
  end

  def test_it_builds_ninety_one_character_array_for_full_functionality
    assert_equal 91, encryptor.characters.count
  end

  def test_it_builds_rotated_characters_array_with_given_rotation
    expected = encryptor.characters[33]
    actual = encryptor.rotated_characters(2)[31]
    assert_equal expected, actual
  end

  def test_it_builds_a_hash_with_original_and_rotated_characters
    cipher_for_current_rotation = encryptor.cipher(1)
    assert_equal "B", cipher_for_current_rotation["A"]
    assert_equal "e", cipher_for_current_rotation["d"]
  end

  def test_it_encrypts_one_character_with_single_rotation
    assert_equal "b", encryptor.encrypt_letter("a", 1)
    assert_equal "6", encryptor.encrypt_letter("1", 5)
  end

  def test_it_builds_rotations_array_based_on_key_and_offsets
    assert_instance_of Array, encryptor.build_rotations
    assert_equal 4, encryptor.build_rotations.count
  end

  def test_it_encrypts_a_letter_string_with_calculated_rotations
    assert_instance_of String, encryptor.encrypt_string("abcd")
  end

  def test_it_encrypts_a_mixed_string
    assert_instance_of String, encryptor.encrypt_string("A!@ *x>+$")
  end

  def test_it_encrypts_string_when_key_and_date_passed_in
    encryptor = Encryptor.new("12345", "030415")
    assert_equal "o ,;", encryptor.encrypt_string("abcd")
  end
end
