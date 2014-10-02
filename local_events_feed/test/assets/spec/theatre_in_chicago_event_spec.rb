require_relative 'spec_helper'
require_relative '../../../lib/assets/theatre_in_chicago_event'

describe TheatreInChicagoEvent do
  let(:blank_event) { TheatreInChicagoEvent.new("20141001") }

  let(:setted_event) do
    setted_event = TheatreInChicagoEvent.new("20141001")
    setted_event.name = "Party"
    setted_event.location = " Everywhere     <tag>  "
    setted_event.time = "07:30:00.000"
    setted_event
  end

  let(:cleaned_event) { cleaned_event = setted_event.clone.clean }


  it 'should not be complete when blank' do
    expect(blank_event).to_not be_complete
  end

  it 'should be complete when all fields are set' do
    expect(setted_event).to be_complete
  end

  it 'should have a clean location when cleaned' do
    expect(cleaned_event.location).to eq("Everywhere")
  end
    
end
