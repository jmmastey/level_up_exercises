class SectionDecorator < Draper::Decorator
  delegate_all

  def new_question_paths
    {
      FillInTheBlankQuestionDecorator.type =>
      h.fill_in_the_blank_question_new_quiz_activity_path(object),
      MultipleChoiceQuestionDecorator.type =>
      h.multiple_choice_question_new_quiz_activity_path(object),
    }
  end
end
