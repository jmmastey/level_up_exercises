require 'theatre_in_chicago/image_finder'

RSpec.describe TheatreInChicago::ImageFinder, :type => :asset do
  let(:showings_node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html")) }
  let(:image) { TheatreInChicago::ImageFinder.find(showings_node) }

  it 'extracts the image address from a showings page containing one' do
    expect(image).to eq('http://www.theatreinchicago.com/images/theatre/generic.jpg')
  end
end
