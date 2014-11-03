require 'rails_helper'

describe 'FlightStats Schedules API' do

  subject(:api) { FlightStats.new }

  it 'should show flights from chicago to new york tomorrow' do
    expect(api.scheduled_flights("ORD", "LGA", 2.days.from_now).length).to be > 0
  end
end