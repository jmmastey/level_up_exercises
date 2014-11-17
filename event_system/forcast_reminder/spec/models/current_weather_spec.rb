require 'rails_helper'

describe CurrentWeather, type: :model do
  it { should validate_uniqueness_of(:station_id) }
end
