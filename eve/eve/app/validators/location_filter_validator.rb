class LocationFilterValidator < ActiveModel::Validator
  def validate(model)
    set_error(model) if model_invalid?(model)
  end

  private

  def set_error(model)
    model.errors[:base] << "Cannot filter by region and by station"
  end

  def model_invalid?(model)
    model.region_id.present? && model.station_id.present?
  end
end
