require 'rails_helper'

describe Forecast, type: :model do
  it { should validate_uniqueness_of(:time).scoped_to(:zip_code) }
end
