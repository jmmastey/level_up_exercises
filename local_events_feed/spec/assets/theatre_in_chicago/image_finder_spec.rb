require 'assets/theatre_in_chicago/image_finder'

RSpec.describe TheatreInChicago::ImageFinder, :type => :asset do
  let(:showings_body) { File.open("test/fixtures/theatre_in_chicago_test_showings_same_year.html").read }
  let(:image) { TheatreInChicago::ImageFinder.find(showings_body) }

  it 'extracts the image address from a showings page containing one' do
    expect(image).to eq('http://www.theatreinchicago.com/images/theatre/generic.jpg')
  end
end
