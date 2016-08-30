require './test/test_helper'

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

  def test_it_decrypts_letter
    encryptor = Encryptor.new("12345", "030415")
    assert_equal "b", encryptor.decrypt_letter("c", 1)
  end

  def test_it_decrypts_string
    encryptor = Encryptor.new("12345", "030415")
    assert_equal "v#5C\"", encryptor.encrypt_string("hello")
    assert_equal "hello", encryptor.decrypt_string("v#5C\"")
  end

  def test_it_cracks
    encryptor = Encryptor.new("12345", "111111")

    assert_equal "X$5?$FDGx(<Ny2Dpu-D4##Do!(<;u1D;u+5B0HRNu--N>H", encryptor.encrypt_string('Hello, this is Ben and Alisher hello .. end ..')
    # assert_equal ".. end ..", encryptor.decrypt_string("9*lzy`lC9")
  end

  def test_it_cracks_again
    encryptor = Encryptor.new("08715", "082916")
    expected = "Sa]&z(l.sed5tolWpjlvy`lVwed\"pnlC9wV(owzC"
    actual = encryptor.encrypt_string('Hello, this is Ben and Alisher .. end ..')
    assert_equal expected, actual
  end
end
