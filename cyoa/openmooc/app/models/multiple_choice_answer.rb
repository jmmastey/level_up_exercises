class MultipleChoiceAnswer < ActiveRecord::Base
  belongs_to :multiple_choice_question

  def self.default(attributes = {})
    new({
      text: '',
    }.merge(attributes))
  end
end
