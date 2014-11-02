require 'assets/theatre_in_chicago/date_range_builder'

RSpec.describe TheatreInChicago::DateRangeBuilder, :type => :asset do
  let(:today) { DateTime.new(2014, 10, 1) }

  let(:date_range_line) { '<p class="detailbody bottomPad">Oct 25 - Jan 4, 2015</p>' }
  let(:date_range_builder) { TheatreInChicago::DateRangeBuilder.new(date_range_line, today) }
  let(:date_range) { date_range_builder.build }

  let(:thru_range_line) { '<p class="detailbody bottomPad">Thru - Jan 4, 2015</p>' }
  let(:thru_range_builder) { TheatreInChicago::DateRangeBuilder.new(thru_range_line, today) }
  let(:thru_range) { thru_range_builder.build }

  let(:open_range_line) { '<p class="detailbody bottomPad">Open Run </p>' }
  let(:open_range_builder) { TheatreInChicago::DateRangeBuilder.new(open_range_line, today) }
  let(:open_range) { open_range_builder.build }

  it 'detects when line that contains a date range' do
    expect(TheatreInChicago::DateRangeBuilder.date_range_detected?(date_range_line)).to be_present
  end

  it 'detects when line that contains a thru range' do
    expect(TheatreInChicago::DateRangeBuilder.date_range_detected?(thru_range_line)).to be_present
  end

  it 'detects when line that contains an open range' do
    expect(TheatreInChicago::DateRangeBuilder.date_range_detected?(open_range_line)).to be_present
  end

  it 'builds a date range from a line containing one' do
    expect(date_range[0].to_s).to eq("2014-10-25 00:00:00 -0500")
    expect(date_range[1].to_s).to eq("2015-01-05 00:00:00 -0600")
  end

  it 'builds a thru range from a line containing one' do
    expect(thru_range[0].to_s).to eq("2014-10-01 00:00:00 -0500")
    expect(thru_range[1].to_s).to eq("2015-01-05 00:00:00 -0600")
  end

  it 'builds a open range of one week from a line containing open-run' do
    expect(open_range[0].to_s).to eq("2014-10-01 00:00:00 -0500")
    expect(open_range[1].to_s).to eq("2014-10-09 00:00:00 -0500")
  end
end
