require 'rails_helper'
require 'theatre_in_chicago/page_parser'

RSpec.describe TheatreInChicago::PageParser, :type => :asset do
  let(:node) { Nokogiri::HTML(File.open("test/fixtures/theatre_in_chicago_test_page.html")) }
  let(:parser) { TheatreInChicago::PageParser.new(node, details_enabled: false) }
  let(:events) { parser.events }

  it 'should extract all events in the body' do
    expect(events.count).to eq(85)
  end

  it 'should show the first event' do
    expect(events[0].name).to eq('Agreed Upon Fictions')
    expect(events[0].location).to eq('16th Street Theater at Berwyn Cultural Center')
    expect(events[0].link).to eq('http://www.theatreinchicago.com/agreed-upon-fictions/7179/')
  end

  it 'should show the second event' do 
    expect(events[1].name).to eq('Alice')
    expect(events[1].location).to eq('Neo-Futurists')
    expect(events[1].link).to eq('http://www.theatreinchicago.com/alice/7200/')
  end

  it 'should show the second-to-last event' do 
    expect(events[83].name).to eq('Whatever We Want')
    expect(events[83].location).to eq('Vivarium Theatre Co. at Heartland Studio Theatre')
    expect(events[83].link).to eq('http://www.theatreinchicago.com/whatever-we-want/7265/')
  end

  it 'should show the last event' do 
    expect(events[3].name).to eq('All My Sons')
    expect(events[3].location).to eq('Raven Theatre')
    expect(events[3].link).to eq('http://www.theatreinchicago.com/all-my-sons/7031/')
  end
end
