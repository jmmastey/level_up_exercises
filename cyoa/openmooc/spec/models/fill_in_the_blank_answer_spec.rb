require 'rails_helper'

RSpec.describe FillInTheBlankAnswer, type: :model do
  describe '::new' do
    it 'initializes with empty string' do
      expect(described_class.new.text).to eq('')
    end
  end
end
