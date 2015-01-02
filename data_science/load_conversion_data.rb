require 'json'

class LoadConversionData
  attr_accessor :data, :sample_key
  SAMPLE_KEY_DEFAULT = "cohort"

  def initialize(json_file, field_info = {})
    self.data = JSON.parse(File.read(json_file))
    self.sample_key = field_info.fetch(:sample_key, SAMPLE_KEY_DEFAULT)
  end

  def sample_data(sample)
    data.select { |user| user[sample_key] == sample }
  end

  def to_s
    data
  end
end
