require 'theatre_in_chicago/description_finder'

RSpec.describe TheatreInChicago::DescriptionFinder, :type => :asset do
  let(:event_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html")) }
  let(:description) { TheatreInChicago::DescriptionFinder.find(event_node) }
  let(:description_beginning) { description.first(20) }
  let(:description_ending) { description.last(20) }

  it 'extracts the description from a showings page' do
    expect(description_beginning).to eq('Crumble (Lay Me Down')
    expect(description_ending).to eq(' absurdly hilarious.')
  end
end
