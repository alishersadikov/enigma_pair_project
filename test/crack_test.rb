require './test/test_helper'
require './lib/encryptor'
require './lib/crack'

class CrackTest < Minitest::Test
  def test_it_accepts_date_as_argument
    crack = Crack.new("083016")
    assert_equal "083016", crack.date
  end

  def test_the_key_is_nil_by_default
    crack = Crack.new("083016")
    assert_equal nil, crack.key
  end

  def test_it_pulls_characters_from_encryptor_class
    crack = Crack.new("083016")

    assert_equal 0, crack.crack_rotations('%8\6en\Z%')
  end
end
