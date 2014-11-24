require 'rails_helper'

RSpec.describe QuizActivity, :type => :model do
  subject(:quiz_activity) do
    described_class.new
  end

  let(:quiz_activity_with_question) do
    FactoryGirl.create(:quiz_activity_with_fill_in_the_blank_question)
  end

  describe '#destroy' do
    it 'destory the question associated' do
      question = quiz_activity_with_question.question
      quiz_activity_with_question.destroy
      expect(FillInTheBlankQuestion.exists?(id: question.id)).to be false
    end
  end
end
