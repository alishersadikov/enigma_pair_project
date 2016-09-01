class OffsetGenerator
  attr_reader :date

  def initialize(date = nil)
    @date = date
  end

  def generate_todays_date
    @date != nil ? @date : @date = Date.today.strftime("%D").split("/").join
  end

  def build_offsets
    generate_todays_date
    squared_date = @date.to_i ** 2
    offsets = squared_date.to_s[-4..-1].chars
    offsets.map { |digit|  digit.to_i }
  end
end
