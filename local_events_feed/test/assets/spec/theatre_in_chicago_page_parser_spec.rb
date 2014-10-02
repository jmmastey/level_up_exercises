require_relative 'spec_helper'
require_relative '../../../lib/assets/theatre_in_chicago_page_parser'

describe TheatreInChicagoPageParser do
  let(:body) { File.open("test/fixtures/theatre_in_chicago_test_page.html").read }
  let(:parser) { TheatreInChicagoPageParser.new(body) }
  let(:events) { parser.events }

  it 'should extract all events in the body' do
    expect(events.count).to eq(6)
  end

  it 'should show the first event' do
    expect(events[0].date).to eq('2014-11-13')
    expect(events[0].time).to eq('19:30:00')
    expect(events[0].name).to eq('Tamer of Horses')
    expect(events[0].location).to eq('Teatro Vista at Victory Gardens Theater - Biograph')
  end

  it 'should show the second event' do 
    expect(events[1].date).to eq('2014-11-14')
    expect(events[1].time).to eq('19:30:00')
    expect(events[1].name).to eq('The Nutcracker')
    expect(events[1].location).to eq ('The House Theatre of Chicago at Chopin Theatre')
  end

  it 'should show the third event' do 
    expect(events[2].date).to eq('2014-11-17')
    expect(events[2].time).to eq('19:30:00')
    expect(events[2].name).to eq('Crumble (Lay Me Down Justin Timberlake)')
    expect(events[2].location).to eq ('Jackalope Theatre Company at Broadway Armory')
  end

  it 'should show the fourth event' do 
    expect(events[3].date).to eq('2014-11-19')
    expect(events[3].time).to eq('19:30:00')
    expect(events[3].name).to eq("Dee Snider's Rock and Roll Christmas Tale")
    expect(events[3].location).to eq ('Broadway In Chicago at Broadway Playhouse')
  end

  it 'should show the fifth event' do 
    expect(events[4].date).to eq('2014-11-21')
    expect(events[4].time).to eq('19:30:00')
    expect(events[4].name).to eq('The Testament of Mary')
    expect(events[4].location).to eq ('Victory Gardens Theater - Biograph')
  end
  
  it 'should show the sixth event' do 
    expect(events[5].date).to eq('2014-11-28')
    expect(events[5].time).to eq('19:30:00')
    expect(events[5].name).to eq('Shining City')
    expect(events[5].location).to eq ('Irish Theatre of Chicago at The Den Theatre')
  end
end
