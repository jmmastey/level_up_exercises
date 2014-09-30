require_relative "binomial_data_group"
require_relative "binomial"

class BinomialDataSet
  include Binomial
  attr_reader :group_field, :groups

  def initialize(params)
    @group_field = params[:group_field]
    @result_field = params[:result_field]
    @data = params[:data]
    @groups = split_into_groups(@data)
  end

  def to_s
    base_string = "DataSet:(total '#{count}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%3f%%')"
    format(base_string, 100 * success_percent)
  end

  private

  def split_into_groups(data)
    raw_groups = data.group_by(&@group_field)
    raw_groups.each do |group_key, group|
      raw_groups[group_key] = parse_group(group_key, group)
    end
  end

  def parse_group(group_key, data)
    BinomialDataGroup.new(id: group_key, data: data,
      group_field: @group_field, result_field: @result_field)
  end
end
