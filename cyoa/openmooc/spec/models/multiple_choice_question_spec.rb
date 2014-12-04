require 'rails_helper'

RSpec.describe MultipleChoiceQuestion, type: :model do
  subject(:test_question) do
    FactoryGirl.build(:multiple_choice_question_with_answers)
  end

  describe '::default' do
    it 'creates a blank answer upon initialization' do
      expect(described_class.default.page_content).to be_a PageContent
      expect(described_class.default).to have(2).answers
      expect(described_class.default.answers.to_a.count(&:correct)).to be 1
    end
  end

  describe '#correct_answer?' do
    it 'correct is matches text of correct answer' do
      expect(test_question.correct_answer? 'correct answer').to be true
    end

    it 'otherwise false' do
      expect(test_question.correct_answer? 'incorrect answer').to be false
    end
  end
end
