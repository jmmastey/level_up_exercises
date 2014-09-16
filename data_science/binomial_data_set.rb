require_relative "./binomial_data_group"

class BinomialDataSet
  attr_reader :group_field, :groups

  def initialize(params)
    @group_field = params[:group_field]
    @result_field = params[:result_field]
    @data = params[:data]
    @groups = split_into_groups(@data)
  end

  def fail_count
    sum_field_in_groups(:fail_count)
  end

  def success_count
    sum_field_in_groups(:success_count)
  end

  def fail_percent
    fail_count.to_f / count
  end

  def success_percent
    success_count.to_f / count
  end

  def count
    sum_field_in_groups(:count)
  end

  def to_s
    format("DataSet:(total '#{count}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%3f)'", success_percent)
  end

  private

  def sum_field_in_groups(field)
    @groups.each_value.inject(0) do |sum, group|
      sum + group.send(field)
    end
  end

  def split_into_groups(data)
    groups = {}
    data.group_by(&@group_field).each do |key, data_row|
      groups[key] = BinomialDataGroup.new(
        id: key, data: data_row,
        group_field: @group_field,
        result_field: @result_field
      )
    end
    groups
  end
end
