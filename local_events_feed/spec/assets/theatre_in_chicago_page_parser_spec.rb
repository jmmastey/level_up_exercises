require 'spec_helper'
require 'assets/theatre_in_chicago_page_parser'

describe TheatreInChicagoPageParser do
  let(:body) { File.open("test/fixtures/theatre_in_chicago_test_page.html").read }
  let(:parser) { TheatreInChicagoPageParser.new(body, showings_enabled: false) }
  let(:events) { parser.events }

  it 'should extract all events in the body' do
    expect(events.count).to eq(6)
  end

  it 'should show the first event' do
    expect(events[0].name).to eq('Tamer of Horses')
    expect(events[0].location).to eq('Teatro Vista at Victory Gardens Theater - Biograph')
    expect(events[0].link).to eq('http://www.theatreinchicago.com/tamer-of-horses/7255/')
  end

  it 'should show the second event' do 
    expect(events[1].name).to eq('The Nutcracker')
    expect(events[1].location).to eq ('The House Theatre of Chicago at Chopin Theatre')
    expect(events[1].link).to eq('http://www.theatreinchicago.com/the-nutcracker/7267/')
  end

  it 'should show the third event' do 
    expect(events[2].name).to eq('Crumble (Lay Me Down Justin Timberlake)')
    expect(events[2].location).to eq ('Jackalope Theatre Company at Broadway Armory')
    expect(events[2].link).to eq('http://www.theatreinchicago.com/crumble-lay-me-down-justin-timberlake/7268/')
  end

  it 'should show the fourth event' do 
    expect(events[3].name).to eq("Dee Snider's Rock and Roll Christmas Tale")
    expect(events[3].location).to eq ('Broadway In Chicago at Broadway Playhouse')
    expect(events[3].link).to eq('http://www.theatreinchicago.com/dee-sniders-rock-and-roll-christmas-tale/6754/')
  end

  it 'should show the fifth event' do 
    expect(events[4].name).to eq('The Testament of Mary')
    expect(events[4].location).to eq ('Victory Gardens Theater - Biograph')
    expect(events[4].link).to eq('http://www.theatreinchicago.com/the-testament-of-mary/6935/')
  end
  
  it 'should show the sixth event' do 
    expect(events[5].name).to eq('Shining City')
    expect(events[5].location).to eq ('Irish Theatre of Chicago at The Den Theatre')
    expect(events[5].link).to eq('http://www.theatreinchicago.com/shining-city/7257/')
  end
end
