require 'rails_helper'
require 'assets/theatre_in_chicago_showing_parser'

RSpec.describe TheatreInChicagoShowingParser, :type => :asset do
  let(:same_year_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html").read }
  let(:same_year_parser) { TheatreInChicagoShowingParser.new(same_year_body) }

  let(:diff_year_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_diff_year.html").read }
  let(:diff_year_parser) { TheatreInChicagoShowingParser.new(diff_year_body) }

  let(:days_of_week_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_days_of_week.html").read }
  let(:days_of_week_parser) { TheatreInChicagoShowingParser.new(days_of_week_body) }

  let(:thru_date_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_thru_date.html").read }
  let(:thru_date_parser) { TheatreInChicagoShowingParser.new(thru_date_body) }

  it 'should extract all events in a body with same year date range' do
    expect(same_year_parser).to have(38).showing_times
  end

  it 'should extract all events in a body with different year date range' do
    expect(diff_year_parser).to have(48).showing_times
  end

  it 'should extract all events in a body with showings in days of week format' do
    expect(days_of_week_parser).to have(48).showing_times
  end

  it 'should extract all events in a body with showings thru-date range format (e.g. Thru - Dec 15, 2015)' do
    expect(thru_date_parser).to have(99).showing_times
  end
end
