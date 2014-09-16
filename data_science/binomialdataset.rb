require_relative "./binomialdatagroup"

class BinomialDataSet
  attr_reader :group_field, :groups

  def initialize(params)
    @group_field = params[:group_field]
    @result_field = params[:result_field]
    @data = params[:data]
    @groups = split_into_groups(@data)
  end

  def fail_count
    sum = 0
    @groups.each do |_id, group|
      sum += group.fail_count
    end
    sum
  end

  def success_count
    sum = 0
    @groups.each do |_id, group|
      sum += group.success_count
    end
    sum
  end

  def fail_percent
    fail_sum = 0
    @groups.each do |_id, group|
      fail_sum += group.fail_count
    end
    fail_sum.to_f / count
  end

  def success_percent
    success_sum = 0
    @groups.each do |_id, group|
      success_sum += group.success_count
    end
    success_sum.to_f / count
  end

  def count
    sum = 0
    @groups.each do |_id, group|
      sum += group.count
    end
    sum
  end

  def to_s
    "total '#{count}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%3f'" % success_percent
  end

  private

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
