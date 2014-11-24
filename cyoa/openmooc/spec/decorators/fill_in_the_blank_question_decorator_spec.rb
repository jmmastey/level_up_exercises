require 'rails_helper'

RSpec.describe FillInTheBlankQuestionDecorator do
  describe '::type' do
    it 'is a human readable type name' do
      expect(described_class.type).to eq 'Fill in the blank question'
    end
  end
end
