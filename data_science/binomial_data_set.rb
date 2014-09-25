require_relative "binomial_data_group"
require_relative "binomialable"

class BinomialDataSet
  include Binomialable
  attr_reader :group_field, :groups

  def initialize(params)
    @group_field = params[:group_field]
    @result_field = params[:result_field]
    @data = params[:data]
    @groups = split_into_groups(@data)
  end

  def to_s
    format("DataSet:(total '#{count}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%3f%%')", 100*success_percent)
  end

  private

  def split_into_groups(data)
    raw_groups = data.group_by(&@group_field)
    raw_groups.each { |key, data| raw_groups[key] = parse_group(key, data) }
  end

  def parse_group(key, data)
    BinomialDataGroup.new(id: key, data: data,
      group_field: @group_field, result_field: @result_field)
  end
end
