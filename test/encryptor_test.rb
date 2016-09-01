require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test

  def encryptor
    ::Encryptor.new
  end

  def test_it_builds_88_one_character_array_for_full_functionality
    assert_equal 88, encryptor.characters.count
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
  end

  def test_it_encrypts_one_character_with_bigger_rotation
    assert_equal "9", encryptor.encrypt_letter("1", 8)
  end

  def test_it_builds_rotations_array_based_on_generated_key_and_offsets
    assert_instance_of Array, encryptor.build_rotations
    assert_equal 4, encryptor.build_rotations.count
  end

  def test_it_returns_a_string_after_encrypting
    assert_instance_of String, encryptor.encrypt_string("abcd")
  end

  def test_key_and_date_are_nil_by_default_when_not_passed_in
    assert encryptor.key_nil?
    assert encryptor.date_nil?
  end

  def test_key_and_date_are_not_nil_when_passed_in
    encryptor = Encryptor.new("12345", "090116")
    refute encryptor.key_nil?
    refute encryptor.date_nil?
  end

  def test_it_builds_rotations_array_with_given_key_and_offsets
    encryptor = Encryptor.new("12345", "090116")
    assert_equal [15, 27, 39, 51], encryptor.build_rotations
  end

  def test_it_encrypts_string_when_key_and_date_passed_in
    encryptor = Encryptor.new("12345", "090116")
    assert_equal "P^1>@MZh2", encryptor.encrypt_string("ABcd1234!")
  end

  def test_it_encrypts_string_when_key_and_date_not_given
    assert_instance_of String, encryptor.encrypt_string("ABcd1234!")
  end

  def test_it_decrypts_letter_with_given_key_and_date
    encryptor = Encryptor.new("12345", "090116")
    assert_equal "b", encryptor.decrypt_letter("c", 1)
  end

  def test_it_decrypts_string_with_given_key_and_date
    encryptor = Encryptor.new("12345", "090116")
    assert_equal "P^1>@MZh2", encryptor.encrypt_string("ABcd1234!")
    assert_equal "ABcd1234!", encryptor.decrypt_string("P^1>@MZh2")
  end
  
  def test_it_decrypts_with_todays_date_when_key_is_given_but_date_not_given
    encryptor = Encryptor.new("12345")
    assert_equal "P^1>@MZh2", encryptor.encrypt_string("ABcd1234!")
    assert_equal "ABcd1234!", encryptor.decrypt_string("P^1>@MZh2")
  end
end
