require 'rails_helper'

RSpec.describe Show, :type => :model do

  describe '#name' do
    it 'has a name' do
      show = FactoryGirl::build(:show)
      expect(show.name).to eq("Show-1")
    end
  end
end
