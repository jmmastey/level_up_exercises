class Page < ActiveRecord::Base
  belongs_to :section
  belongs_to :activity, polymorphic: true, dependent: :destroy
  has_one :course, through: :section
  acts_as_list scope: :section
end
