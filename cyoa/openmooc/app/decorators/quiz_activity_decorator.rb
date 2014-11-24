class QuizActivityDecorator < PartialDecorator
  delegate_all

  def type
    'Quiz'
  end

  def new_question_paths
    object.section.decorate.new_question_paths
  end

  def edit_question_paths
    all_edit_question_paths.merge({
      QuizActivity.find(object.id).question.decorate.type => 'edit'
    })
  end

  def next_page_text
    'Skip quiz'
  end

  private

  def all_edit_question_paths
    {
      FillInTheBlankQuestionDecorator.type =>
      h.update_fill_in_the_blank_question_quiz_activity_path(object.id),
      MultipleChoiceQuestionDecorator.type =>
      h.update_multiple_choice_question_quiz_activity_path(object.id),
    }
  end
end
