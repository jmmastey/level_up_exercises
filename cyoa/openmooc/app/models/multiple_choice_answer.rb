class MultipleChoiceAnswer < ActiveRecord::Base
  belongs_to :multiple_choice_question
  after_initialize :init

  def init
    self.text ||= ''
  end
end
