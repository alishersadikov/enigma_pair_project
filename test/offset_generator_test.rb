require './test/test_helper'
require './lib/offset_generator'

class OffsetGeneratorTest < Minitest::Test

  def test_it_accepts_date_argument
    offset = OffsetGenerator.new("020315")
    assert_equal "020315", offset.date
  end

  def test_it_builds_offset_array_for_passed_date
    offset = OffsetGenerator.new("020315")
    assert_equal [9, 2, 2, 5], offset.build_offsets
  end

  def test_it_generates_todays_date_if_no_paramater_passed
    offset = OffsetGenerator.new
    expected = Date.today.strftime("%D").split("/").join
    assert_equal expected, offset.generate_todays_date
  end

  def test_it_builds_offset_array_for_todays_date
    offset = OffsetGenerator.new
    assert_instance_of Array, offset.build_offsets
    assert_equal 4, offset.build_offsets.size
  end
end
