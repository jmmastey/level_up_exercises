class FillInTheBlankAnswer < ActiveRecord::Base
  belongs_to :fill_in_the_blank_question
  after_initialize :init

  def self.from_alias(_alias)
    new(text: _alias['text'])
  end

  def init
    self.text ||= ''
  end
end
