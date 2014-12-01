require 'rails_helper'

RSpec.describe Flight, type: :model do
  def create_with_nil(field)
    FactoryGirl.create(:flight, field => nil)
  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:flight)).to be_valid
  end

  it "requires destination airport" do
    expect { create_with_nil(:destination_airport) }.to raise_error
  end

  it "requires destination time" do
    expect { create_with_nil(:destination_date_time) }.to raise_error
  end

  it "requires origin airport" do
    expect { create_with_nil(:origin_airport) }.to raise_error
  end

  it "requires origin time" do
    expect { create_with_nil(:origin_date_time) }.to raise_error
  end

end
