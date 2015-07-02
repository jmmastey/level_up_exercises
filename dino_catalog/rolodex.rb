class Rolodex
  def initialize
    extend Hirb::Console
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end
end
