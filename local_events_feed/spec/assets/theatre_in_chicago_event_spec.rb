require 'rails_helper'
require 'assets/theatre_in_chicago_event'

RSpec.describe TheatreInChicagoEvent, :type => :asset do
  let(:blank_event) { TheatreInChicagoEvent.new }

  let(:setted_event) do
    setted_event = TheatreInChicagoEvent.new
    setted_event.name = "Party"
    setted_event.location = " Everywhere     <tag>  "
    setted_event.showings << DateTime.parse("20141001T073000")
    setted_event.link = "http://www.event.com"
    setted_event
  end

  let(:cleaned_event) { setted_event.clone.clean }
  let(:other_event) { setted_event.clone }
  let(:model_event) { setted_event.to_event_model }



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

  it 'converts to a valid Event model' do
    expect(model_event).to be_valid
  end

  it 'adds a single show to the event show' do
    expect(model_event).to have(1).showing
  end

  it "converts to a string correctly" do
    expect(cleaned_event.to_s).to eq('Party, Everywhere, http://www.event.com')
  end
end
