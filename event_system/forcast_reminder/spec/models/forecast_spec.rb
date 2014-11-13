require 'rails_helper'

describe Forecast, :type => :model do
  it { should validate_uniqueness_of(:date, :zip_code) }
end
