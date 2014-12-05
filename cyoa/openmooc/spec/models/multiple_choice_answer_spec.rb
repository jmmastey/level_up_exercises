require 'rails_helper'

RSpec.describe MultipleChoiceAnswer, type: :model do
  describe '::defaults' do
    it 'creates an answer with the empty string' do
      expect(described_class.default.text).to eq ''
    end
  end
end
