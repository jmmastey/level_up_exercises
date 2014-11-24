require 'rails_helper'

RSpec.describe QuizActivityDecorator do
  subject(:activity) do
    FactoryGirl.create(:quiz_activity_with_fill_in_the_blank_question)
  end

  let(:expected_paths) do
    {
      'Multiple choice question' =>
      update_multiple_choice_question_quiz_activity_path(activity.id),
      'Fill in the blank question' =>
      'edit',
    }
  end

  describe '#edit_question_paths' do
    it 'creates link text and path for possible new questions' do
      expect(activity.decorate.edit_question_paths).to eq(expected_paths)
    end
  end
end
