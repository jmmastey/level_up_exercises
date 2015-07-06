class TestData
  attr_reader :data_sample

  def initialize(data_sample)
    @data_sample = data_sample
  end

  def sample_size
    data_sample.length
  end

  def group_count(group_name, group_member)
    data_sample.count { |data| data[group_name] == group_member }
  end

  def conversions_count(group_name, group_member, result)
    data_sample.count do |data|
      data[group_name] == group_member && data[result] == 1
    end
  end

  def group_members(group_name)
    data_sample.map { |data| data[group_name] }.uniq
  end
end
