require 'assets/theatre_in_chicago/name_and_link_extractor'

RSpec.describe TheatreInChicago::NameAndLinkExtractor, :type => :asset do
  let(:line) { '<a href="/the-wild-party/7247/" class="detailhead"><strong>The Wild Party</strong></a>' }
  let(:event) { Event.new }
  let(:extract) { TheatreInChicago::NameAndLinkExtractor.extract(line, event) }

  it 'extracts the event name and link from a line containing them' do
    expect(extract.name).to eq('The Wild Party')
    expect(extract.link).to eq('http://www.theatreinchicago.com/the-wild-party/7247/')
  end

  it "deems and event's name and link to be complete when they are in fact complete" do
    expect(TheatreInChicago::NameAndLinkExtractor.complete?(extract)).to be true
  end

  it "deems and event's name and link to be incomplete when they are in fact incomplete" do
    expect(TheatreInChicago::NameAndLinkExtractor.complete?(event)).not_to be true
  end
end
