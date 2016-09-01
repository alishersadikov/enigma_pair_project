require './test/test_helper'
require './lib/encryptor'
require './lib/crack'

class CrackTest < Minitest::Test

  def crack
    ::Crack.new("090116")
  end

  def test_it_accepts_date_as_argument
    assert_equal "090116", crack.date
  end

  def test_it_has_standard_message_ending_to_base_calculations_on
    assert_equal "..end..", crack.standard_epilogue
  end

  def test_the_key_is_nil_by_default
    assert_equal nil, crack.key
  end

  def test_it_cracks_rotations
    my_message = "ntVZuuacm iZ_o`Ln.uo_zQo("
    assert_equal [82, 12, 70, 64], crack.crack_rotations(my_message)
  end

  def test_adjusted_rotations
    my_message = "ntVZuuacm iZ_o`Ln.uo_zQo("
    actual = crack.adjusted_rotations(my_message, [49, 7, -52, -28])
    assert_equal [49, 60, 36, 7], actual
  end

  def test_encrypted_characters_are_zipped_with_standard_characters
    expected = [[".", "%"], [".", "Z"], ["d", "\\"], ["n", "n"]]
    assert_equal expected, crack.zip_characters('%8\6en\Z%')
  end

  def test_it_cracks_the_string_from_the_back
    assert_equal "..end..", crack.crack_string('[Or`8O;')
  end

  def test_it_cracks_longer_string
    my_message = "this is so secret ..end.."
    encrypted_message = "ntVZuuacm iZ_o`Ln.uo_zQo("
    assert_equal my_message, crack.crack_string(encrypted_message)
  end

  def test_it_builds_offsets_array_from_the_given_date
    assert_equal [3, 4, 5, 6], crack.build_date_offsets
  end

  def test_it_calculates_the_key_used_to_encrypt
    my_message = "ntVZuuacm iZ_o`Ln.uo_zQo("
    assert_equal "79658", crack.calculate_key(my_message)
  end

  def test_it_builds_string_from_key_array
    assert_equal "79658", crack.build_calculated_key_string([79, 96, 65, 58])
  end

  def test_it_rjusts_the_one_digit_key_elements
    assert_equal "70658", crack.build_calculated_key_string([70, 6, 65, 58])
  end
end
