require 'rails_helper'
require 'rspec/collection_matchers'

RSpec.describe PartialDecorator do
  let(:decorator) do
    described_class.new(QuizActivity.new)
  end

  describe '#to_partial_path' do
    it 'allow the file to be defined in an argument' do
      expect(decorator.to_partial_path(:show)).to eq('quiz_activities/show')
    end

    it 'defaults to the old method otherwise' do
      expect(decorator.to_partial_path).to eq('quiz_activities/quiz_activity')
    end
  end
end
