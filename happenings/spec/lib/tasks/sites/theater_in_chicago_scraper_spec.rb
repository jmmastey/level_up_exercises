# File theater_in_chicago_scraper_spec.rb
require 'rails_helper'
require_relative '../../../../lib/tasks/sites/theater_scraper'

describe TheaterScraper do
  let(:scraper){TheaterScraper.new}
  context "Initial" do
    subject {scraper.url}
    it {is_expected.not_to be_nil}

  end
end