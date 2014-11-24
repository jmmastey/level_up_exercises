class MultipleChoiceQuestionDecorator < PartialDecorator
  delegate_all

  def self.type
    @type ||= 'Multiple choice question'.freeze
  end

  def type
    self.class.type
  end

  def create_for_section_url
    h.create_for_section_multiple_choice_questions_path
  end
end
