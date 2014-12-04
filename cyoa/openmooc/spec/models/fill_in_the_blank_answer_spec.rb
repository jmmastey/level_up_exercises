require 'rails_helper'

RSpec.describe FillInTheBlankAnswer, type: :model do
  describe '::default' do
    it 'initializes with empty string' do
      expect(described_class.default.text).to eq('')
    end
  end
end
