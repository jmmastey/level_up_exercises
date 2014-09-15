
class DataSet
  attr_reader :grouping_field, :control_id, :result_field

  def initialize(params)
    @grouping_field = params[:grouping_field]
    @control_id = params[:control_id]
    @dataset = params[:data]
    @result_field = params[:result_field]
  end

  def split_into_groups(data)
    data.group_by(&@grouping_field)
  end

  def percentage_fail
    1 - _percentage_success(@dataset)
  end

  def percentage_fail_by_group(group_key)
    1 - percentage_success_by_group(group_key)
  end

  def percentage_success
    _percentage_success(@dataset)
  end

  def percentage_success_by_group(group_key)
    dataset = split_into_groups(@dataset)[group_key]
    _percentage_success(dataset)
  end

  private

  def _percentage_success(dataset)
    success_count(dataset).to_f / dataset.size
  end

  def success_count(dataset)
    dataset.count(&@result_field)
  end
end
