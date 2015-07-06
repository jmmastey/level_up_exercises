class TestData
  attr_reader :data_sample, :group_name

  def initialize(data_sample, group_name)
    @data_sample = data_sample
    @group_name = group_name
  end

  def sample_size
    data_sample.length
  end

  def trial_size(group_member)
    data_sample.count { |data| data[group_name] == group_member }
  end

  def conversions_count(group_member, result = 'result')
    data_sample.count do |data|
      data[group_name] == group_member && data[result] == 1
    end
  end

  def group_members
    data_sample.map { |data| data[group_name] }.uniq
  end

  def conversion_percentage(group_member)
    conversions_count(group_member).to_f /
      trial_size(group_member).to_f
  end

  def standard_error(group_member)
    #Standard Error (SE) = Square root of (p * (1-p) / n)
    p = conversions_count(group_member)
    n = trial_size(group_member)

    #((Math.sqrt(p * (1 - p) / n)))
  end

end
