require 'theatre_in_chicago/showing_finder'
require_relative 'fixture_helper'

RSpec.describe TheatreInChicago::ShowingFinder, :type => :asset do
  let(:event_node) { Nokogiri::HTML(open_file("theatre_in_chicago_test_showings_same_year.html")) }
  let(:showings) { TheatreInChicago::ShowingFinder.find(event_node) }

  it 'extracts the showing from a showings page' do
    expect(showings.count).to eq(20)
  end
end
