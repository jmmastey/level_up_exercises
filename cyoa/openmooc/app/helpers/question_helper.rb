module QuestionHelper
  def new_question_paths(lesson)
    {
      FillInTheBlankQuestionDecorator.type =>
      new_fill_in_the_blank_question_path(lesson_id: lesson.id),
      MultipleChoiceQuestionDecorator.type =>
      new_multiple_choice_question_path(lesson_id: lesson.id),
    }
  end
end
