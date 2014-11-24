require 'rails_helper'

RSpec.describe MultipleChoiceAnswer, type: :model do
  describe '::new' do
    it 'creates an answer with the empty string' do
      expect(described_class.new.text).to eq ''
    end
  end
end
