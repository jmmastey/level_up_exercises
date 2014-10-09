require 'spec_helper'
require 'assets/theatre_in_chicago_event'

describe TheatreInChicagoEvent do
  let(:blank_event) { TheatreInChicagoEvent.new("20141001") }

  let(:setted_event) do
    setted_event = TheatreInChicagoEvent.new("20141001")
    setted_event.name = "Party"
    setted_event.location = " Everywhere     <tag>  "
    setted_event.time = "07:30:00.000"
    setted_event.link = "http://www.event.com"
    setted_event
  end

  let(:cleaned_event) { setted_event.clone.clean }
  let(:other_event) { setted_event.clone }



  it 'is not complete when blank' do
    expect(blank_event).to_not be_complete
  end

  it 'is complete when all fields are set' do
    expect(setted_event).to be_complete
  end

  it 'has a clean location when cleaned' do
    expect(cleaned_event.location).to eq("Everywhere")
  end

  it 'matches another event that has identical fields' do
    expect(setted_event.match?(other_event))
  end
end
