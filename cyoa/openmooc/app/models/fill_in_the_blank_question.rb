class FillInTheBlankQuestion < ActiveRecord::Base
  belongs_to :page_content
  has_many :answers, class_name: 'FillInTheBlankAnswer', dependent: :destroy
  has_one :page, as: :content
  has_one :lesson, through: :page
  accepts_nested_attributes_for :answers, allow_destroy: true
  accepts_nested_attributes_for :page_content

  def self.default(attributes = {})
    new({
      answers: [FillInTheBlankAnswer.new],
      page_content: PageContent.new,
    }.merge(attributes))
  end

  def correct_answer?(text)
    answers.any? do |answer|
      answer.correct? text
    end
  end

  def to_s
    page_content.to_s
  end
end
