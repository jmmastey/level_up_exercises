class TestData
  attr_reader :data_sample, :group_name

  # The value of 1.96 refers to the 95th percentile of a standard
  # normal distribution. This is multiplied by the standard error.
  CONFIDENCE_INTERVAL = 1.96

  def initialize(data_sample, group_name)
    @data_sample = data_sample
    @group_name = group_name
  end

  def sample_size
    data_sample.length
  end

  def trial_size(variant)
    data_sample.count { |data| data[group_name] == variant }
  end

  def conversions_count(variant, result = 'result')
    data_sample.count do |data|
      data[group_name] == variant && data[result] == 1
    end
  end

  def group_variants
    data_sample.map { |data| data[group_name] }.uniq
  end

  def conversion_percentage(variant)
    conversions_count(variant).to_f / trial_size(variant).to_f
  end

  def standard_error(variant)
    p = conversion_percentage(variant)
    n = trial_size(variant)

    ((Math.sqrt(p * (1 - p) / n)) * CONFIDENCE_INTERVAL)
  end
end
