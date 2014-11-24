require 'rails_helper'
require 'theatre_in_chicago/date_list_showing_parser'
require 'theatre_in_chicago/dows_showing_parser'

RSpec.describe TheatreInChicago::ShowingParser, :type => :asset do
  let(:pseudo_today) { DateTime.new(2014, 10, 31) }

  let(:same_year_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html")) }
  let(:same_year_parser) { TheatreInChicago::DateListShowingParser.new(same_year_node, pseudo_today) }

  let(:diff_year_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_diff_year.html")) }
  let(:diff_year_parser) { TheatreInChicago::DateListShowingParser.new(diff_year_node, pseudo_today) }

  let(:thru_date_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_thru_date.html")) }
  let(:thru_date_parser) { TheatreInChicago::DowsShowingParser.new(thru_date_node, pseudo_today) }

  let(:days_of_week_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_days_of_week.html")) }
  let(:days_of_week_parser) { TheatreInChicago::DowsShowingParser.new(days_of_week_node, pseudo_today) }


  it 'should extract all events in a body with same year date range' do
    expect(same_year_parser).to have(20).showings
  end

  it 'should extract all events in a body with different year date range' do
    expect(diff_year_parser).to have(26).showings
  end

  it 'should extract all events in a body with showings in days of week format' do
    expect(days_of_week_parser).to have(49).showings
  end

  it 'should extract all events in a body with showings thru-date range format (e.g. Thru - Dec 15, 2015)' do
    expect(thru_date_parser).to have(77).showings
  end
end
