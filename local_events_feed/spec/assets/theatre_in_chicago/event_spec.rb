require 'rails_helper'
require 'assets/theatre_in_chicago/event'

RSpec.describe TheatreInChicago::Event, :type => :asset do
  let(:blank_event) { TheatreInChicago::Event.new }

  let(:setted_event) do
    setted_event = TheatreInChicago::Event.new
    setted_event.name = "Party"
    setted_event.location = " Everywhere      "
    setted_event.link = "http://www.event.com"
    setted_event.image = "http://www.event.com/ picture.jpg"
    setted_event.description = "A nice description"
    setted_event.showings << DateTime.parse("20141001T073000")
    setted_event
  end

  let(:cleaned_event) { setted_event.clone.clean }
  let(:other_event) { setted_event.clone }
  let(:model_event) { cleaned_event.to_event_model }

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
    expect(model_event.name).to eq("Party")
    expect(model_event.location).to eq("Everywhere")
    expect(model_event.link).to eq("http://www.event.com")
    expect(model_event.image).to eq("http://www.event.com/picture.jpg")
    expect(model_event.description).to eq("A nice description")
  end

  it 'adds a single show to the event show' do
    expect(setted_event).to have(1).showing
  end

  it "converts to a string correctly" do
    expect(cleaned_event.to_s).to eq('Party, Everywhere, http://www.event.com, http://www.event.com/picture.jpg')
  end
end
