class MultipleChoiceQuestion < ActiveRecord::Base
  has_one :quiz_activity, as: :question
  belongs_to :page_content
  has_many :answers, class_name: 'MultipleChoiceAnswer'
  has_one :page, through: :quiz_activity
  has_one :section, through: :quiz_activity
  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :page_content
  after_initialize :init

  def init
    self.page_content ||= PageContent.new
    self.answers = [ correct_answer, incorrect_answer ] if answers.empty?
  end

  def correct_answer?(text)
    answers.any? do |answer|
      answer.correct && answer.text == text
    end
  end

  def to_s
    page_content.to_s
  end

  private

  def correct_answer
    MultipleChoiceAnswer.new(correct: true)
  end

  def incorrect_answer
    MultipleChoiceAnswer.new(correct: false)
  end
end
