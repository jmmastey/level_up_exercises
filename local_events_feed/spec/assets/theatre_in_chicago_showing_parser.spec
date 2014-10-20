require 'spec_helper'
require 'assets/theatre_in_chicago_showing_parser'

describe TheatreInChicagoShowingParser do
  let(:body) { File.open("test/fixtures/theatre_in_chicago_test_showings.html").read }
  let(:parser) { TheatreInChicagoShowingParser.new(body) }
  let(:showing_times) { parser.showing_times }

  it 'should extract all events in the body' do
    expect(parser).to have(20).showing_times
  end
end
