require "nws/rest_service"

class Forecast < ActiveRecord::Base
  has_many :periods, -> { order "start ASC" }, dependent: :destroy
  scope :recent, (lambda do |zip_code|
    includes(periods: :predictions)
      .where(zip_code: zip_code)
      .where(["created_at > ?", 12.hours.ago])
  end)

  def self.retrieve(zip_code)
    retrieved_forecast = retrieve_forecast(zip_code)
    store_forecast(retrieved_forecast)
  end

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

  private

  def self.retrieve_forecast(zip_code)
    NWS::RestService.forecast_by_zip_code(zip_code, days: 7)
  end

  def self.store_forecast(forecast)
    new_forecast = nil
    ActiveRecord::Base.transaction do
      new_forecast = Forecast.create!(zip_code: forecast.zip_code)
      forecast.periods.each_pair do |name, attributes|
        store_period(new_forecast, name, attributes)
      end
    end
    new_forecast
  end

  def self.store_period(forecast, name, attributes)
    period = Period.create!(name: name, start: attributes[:start_time],
      end: attributes[:end_time], forecast: forecast)
    attributes[:predictions].each_pair do |label, value|
      Prediction.create!(label: label, value: value, period: period)
    end
  end
end
