require 'theatre_in_chicago/date_range_builder'

RSpec.describe TheatreInChicago::DateRangeBuilder, :type => :asset do

  let(:pseudo_today) { DateTime.new(2014, 10, 31) }

  let(:same_year_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html")) }
  let(:same_year_date_range) { TheatreInChicago::DateRangeBuilder.new(same_year_node, pseudo_today).build }

  let(:diff_year_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_diff_year.html")) }
  let(:diff_year_date_range) { TheatreInChicago::DateRangeBuilder.new(diff_year_node, pseudo_today).build }

  let(:thru_year_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_thru_date.html")) }
  let(:thru_year_date_range) { TheatreInChicago::DateRangeBuilder.new(thru_year_node, pseudo_today).build }

  let(:open_run_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_open_run.html")) }
  let(:open_run_date_range) { TheatreInChicago::DateRangeBuilder.new(open_run_node, pseudo_today).build }

  let(:empty_date_node) { Nokogiri::HTML("nonsense") }
  let(:empty_date_range) { TheatreInChicago::DateRangeBuilder.new(empty_date_node, pseudo_today).build }



  it 'builds a date range from a document that has same years' do
    expect(same_year_date_range[0].to_s).to eq("2014-11-13 00:00:00 -0600")
    expect(same_year_date_range[1].to_s).to eq("2014-12-21 00:00:00 -0600")
  end

  it 'builds a date range from a document that has different years' do
    expect(diff_year_date_range[0].to_s).to eq("2014-10-25 00:00:00 -0500")
    expect(diff_year_date_range[1].to_s).to eq("2015-01-05 00:00:00 -0600")
  end

  it 'builds a date range from a document that has thru-year format' do
    expect(thru_year_date_range[0].to_s).to eq("2014-10-31 00:00:00 -0500")
    expect(thru_year_date_range[1].to_s).to eq("2015-01-05 00:00:00 -0600")
  end

  it 'builds a date range from a document that has open-run format' do
    expect(open_run_date_range[0].to_s).to eq("2014-10-31 00:00:00 -0500")
    expect(open_run_date_range[1].to_s).to eq("2014-11-08 00:00:00 -0600")
  end

  it 'returns an empty date range when given a document that contains no date range' do
    expect(empty_date_range).to be_blank
  end
end
