require './test/test_helper'
require './lib/encryptor'
require './lib/crack'

class CrackTest < Minitest::Test

  def crack
    ::Crack.new("083116")
  end

  def test_it_accepts_date_as_argument
    assert_equal "083116", crack.date
  end

  def test_the_key_is_nil_by_default
    assert_equal nil, crack.key
  end

  def test_it_cracks_rotations
    assert_equal [38, 7, 50, 62], crack.crack_rotations('T5<Q/5`')
  end

  def test_adjusted_rotations
    actual = crack.adjusted_rotations('T5<Q/5`',[50, 7, -53, -29])
    assert_equal [38, 7, 50, 62], actual
  end

  def test_encrypted_characters_are_zipped_with_standard_characters
    expected = [[".", "%"], [".", "Z"], ["d", "\\"], ["n", "n"]]
    assert_equal expected, crack.zip_characters('%8\6en\Z%')
  end

  def test_it_cracks_string
    assert_equal "..end..", crack.crack_string('T5<Q/5`')
  end

  def test_it_cracks_longer_string
    my_message = "this is so secret ..end.."
    encrypted_message = "!m%p(n/x t7pmh.b!%E+ms +6"
    assert_equal my_message, crack.crack_string(encrypted_message)
  end

  def test_it_builds_offsets_array_from_the_given_date
    assert_equal [9, 4, 5, 6], crack.build_date_offsets
  end

  def test_it_calculates_the_key_used_to_encrypt
    assert_equal "20456", crack.calculate_key('T5<Q/5`')
  end

  def test_it_cracks_string
    assert_equal "", crack.calculate_key('[wmB6w6')

  end
  def test_it_builds_string_from_key_array
    assert_equal "20456", crack.build_calculated_key_string([29, 3, 45, 56])
  end
end
