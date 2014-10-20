require 'rails_helper'
require 'assets/theatre_in_chicago_showing_parser'

RSpec.describe TheatreInChicagoShowingParser, :type => :asset do
  let(:same_year_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html").read }
  let(:same_year_parser) { TheatreInChicagoShowingParser.new(same_year_body) }
  let(:same_year_showing_times) { same_year_parser.showing_times }

  let(:diff_year_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_diff_year.html").read }
  let(:diff_year_parser) { TheatreInChicagoShowingParser.new(diff_year_body) }
  let(:diff_year_showing_times) { diff_year_parser.showing_times }

  it 'should extract all events in a body with same year date range' do
    expect(same_year_parser).to have(38).showing_times
  end

  it 'should extract all events in a body with different year date range' do
    expect(diff_year_parser).to have(48).showing_times
  end
end
