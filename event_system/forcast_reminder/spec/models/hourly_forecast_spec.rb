require 'rails_helper'

RSpec.describe HourlyForecast, type: :model do
  it { should validate_uniqueness_of(:time).scoped_to(:zip_code) }
end
