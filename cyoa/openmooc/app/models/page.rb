class Page < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :content, polymorphic: true, dependent: :destroy
  has_one :course, through: :lesson
  acts_as_list scope: :lesson
end
