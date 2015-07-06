class TestData
  attr_reader :data_sample

  def initialize(data_sample)
    @data_sample = data_sample
  end

  def sample_size
    data_sample.length
  end

  # should this be trial_size?
  def group_count(group_name, group_member)
    data_sample.count { |data| data[group_name] == group_member }
  end

  def conversions_count(group_name, group_member, result = 'result')
    data_sample.count do |data|
      data[group_name] == group_member && data[result] == 1
    end
  end

  def group_members(group_name)
    data_sample.map { |data| data[group_name] }.uniq
  end

  def conversion_percentage(group_name, group_member)
    conversions_count(group_name, group_member).to_f /
      group_count(group_name, group_member).to_f
  end

  def standard_error(group_name, group_member)
    #Standard Error (SE) = Square root of (p * (1-p) / n)
    p = conversions_count(group_name, group_member)
    n = group_count(group_name, group_member)

    ((Math.sqrt(p * (1 - p) / n)))
  end

end
