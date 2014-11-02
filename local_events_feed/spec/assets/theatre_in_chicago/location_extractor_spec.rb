require 'assets/theatre_in_chicago/location_extractor'

RSpec.describe TheatreInChicago::LocationExtractor, :type => :asset do
  let(:line) { "<a href='http://www.theatreinchicago.com/theatredetail.php?theatreID=174'>" }
  let(:event) { TheatreInChicago::Event.new; }
  let(:extract) { TheatreInChicago::LocationExtractor.extract(line, event) }

  let(:complete_location_event) do
    event = Event.new
    event.location = 'stuff...</a>'
    event
  end

  let(:incomplete_location_event) do
    event = Event.new
    event.location = 'stuff...'
    event
  end


  it 'recognizes a complete event' do
    expect(TheatreInChicago::LocationExtractor.complete?(complete_location_event)).to be_present
  end

  it 'recognizes an incomplete event' do
    expect(TheatreInChicago::LocationExtractor.complete?(incomplete_location_event)).to be_blank
  end

  it 'extracts the location from a line containing one' do
    expect(extract.location).to eq(line)
  end
end
