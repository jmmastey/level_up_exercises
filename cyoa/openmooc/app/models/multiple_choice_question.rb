class MultipleChoiceQuestion < ActiveRecord::Base
  belongs_to :page_content
  has_many :answers, class_name: 'MultipleChoiceAnswer'
  has_one :page, as: :content
  has_one :lesson, through: :page
  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :page_content

  def self.default(attributes = {})
    new({
      page_content: PageContent.new,
      answers: [correct_answer, incorrect_answer],
    }.merge(attributes))
  end

  def self.correct_answer
    MultipleChoiceAnswer.new(correct: true)
  end

  def self.incorrect_answer
    MultipleChoiceAnswer.new(correct: false)
  end

  def correct_answer?(text)
    answers.any? do |answer|
      answer.correct && answer.text == text
    end
  end

  def to_s
    page_content.to_s
  end
end
