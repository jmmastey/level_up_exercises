require 'rails_helper'

RSpec.describe PageDecorator do
  subject(:page_decorator) do
    FactoryGirl.build(:page).decorate
  end

  describe '#number' do
    it 'returns the position' do
      expect(page_decorator.number).to eq(page_decorator.object.position)
    end
  end
end
