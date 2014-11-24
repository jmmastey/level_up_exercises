class QuizActivity < ActiveRecord::Base
  has_one :page, as: :activity
  has_one :section, through: :page
  belongs_to :question, polymorphic: true, dependent: :destroy
end
