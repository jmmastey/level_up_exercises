class QuestionDecorator < PartialDecorator
  def submit_button_text
    if new_record?
      'Create Question'
    else
      'Update Question'
    end
  end
end
