
class DataSet
  attr_reader :group_field, :control_id, :result_field

  def initialize(params)
    @group_field = params[:group_field]
    @control_id = params[:control_id]
    @dataset = params[:data]
    @result_field = params[:result_field]
  end

  def fail_count(params = {})
    dataset = dataset_group(params[:group])
    _fail_count(dataset)
  end

  def success_count(params = {})
    dataset = dataset_group(params[:group])
    _success_count(dataset)
  end

  def fail_percent(params = {})
    dataset = dataset_group(params[:group])
    _fail_count(dataset).to_f / dataset.size
  end

  def success_percent(params = {})
    dataset = dataset_group(params[:group])
    _success_count(dataset).to_f / dataset.size
  end

  def groups
    @dataset.group_by(&@group_field)
  end

  private

  def dataset_group(group_key)
    if group_key.nil?
      @dataset
    else
      groups[group_key]
    end
  end

  def _success_count(dataset)
    dataset.count(&@result_field)
  end

  def _fail_count(dataset)
    dataset.size - _success_count(dataset)
  end
end
