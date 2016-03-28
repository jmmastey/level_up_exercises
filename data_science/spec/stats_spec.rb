require 'spec_helper'

describe DataScience::Stats do
  before do
    data = DataScience::WebsiteData.new("test_data.json")
    @stats = DataScience::Stats.new(data)
  end
  
  describe '#to_s' do
    it 'formats the website data as a string of stats' do
      expect(@stats.to_s).to be_a(String)
    end
  end
end