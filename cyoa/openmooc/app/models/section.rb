class Section < ActiveRecord::Base
  has_many :pages, -> { order 'position ASC' }, dependent: :destroy
  belongs_to :course
  acts_as_list scope: :course
end
