class Forecast < ActiveRecord::Base
  has_many :periods, -> { order "start ASC" }, dependent: :destroy
  scope :recent, (lambda do |zip_code|
    includes(periods: :predictions)
      .where(zip_code: zip_code)
      .where(["created_at > ?", 12.hours.ago])
  end)

  def prediction_for_period(prediction_label, period_name)
    period = periods.find { |p| p.name == period_name }
    return "--" unless period
    prediction = period.predictions.find do |p|
      p.label == prediction_label
    end
    return "--" if prediction.nil? || prediction.value.empty?
    prediction.value
  end

  def to_json(options = {})
    options[:only] ||= [:zip_code]
    options[:include] ||= {
      periods: { only: [:name, :start, :end],
                 include: { predictions: { only: [:label, :value] } } },
    }
    super(options)
  end
end
