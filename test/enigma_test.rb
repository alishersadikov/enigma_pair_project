require './test/test_helper'
require './lib/offset_generator'
require './lib/key_generator'
require './lib/encryptor'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def enigma
    ::Enigma.new
  end

  def test_it_encrypts_string_with_given_key_and_date
    assert_equal "o ,;", enigma.encrypt("abcd", "12345", "030415")
  end

  def test_it_returns_a_string_when_key_and_date_not_given
    assert_instance_of String, enigma.encrypt("abcd")
  end

  def test_output_is_different_when_key_and_date_given_and_not_given
    expected = enigma.encrypt("abcd", "12345", "030415")
    actual = enigma.encrypt("abcd")

    refute_equal expected, actual
  end

  def test_it_encrypts_a_longer_string
    my_message = "this is so secret ..end.."
    actual = enigma.encrypt(my_message, "12345", "030415")

    assert_equal "'&2J.'<R&-DJs!;<'9R`s,-`<", actual
  end

end
