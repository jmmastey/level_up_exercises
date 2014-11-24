require 'rails_helper'

RSpec.describe FillInTheBlankQuestion, type: :model do
  subject(:test_question) do
    FactoryGirl.build(:fill_in_the_blank_question_with_answers)
  end

  describe '::new' do
    it 'creates a blank answer upon initialization' do
      expect(described_class.new.page_content).to be_a PageContent
      expect(described_class.new).to have(1).answer
      expect(described_class.new.answers.first).to be_a FillInTheBlankAnswer
    end
  end

  describe '#correct_answer?' do
    it 'determines if answer is correct on match' do
      expect(test_question.correct_answer? 'Test Answer').to be true
    end

    it 'false if does not match' do
      expect(test_question.correct_answer? 'Answer').to be false
    end

    it 'ignores leading and trailing whitespace' do
      expect(test_question.correct_answer? ' Test Answer ').to be true
    end

    it 'ignores case' do
      expect(test_question.correct_answer? 'tEST aNSWER').to be true
    end
  end

  describe '#to_s' do
    it 'uses page_content to_s' do
      expect(described_class.new.to_s).to eq(described_class.new.page_content.to_s)
    end
  end
end
