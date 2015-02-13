class Legislator < ActiveRecord::Base
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :state_name, presence: true
  validates :term_state, presence: true
  validates :term_end, presence: true
  validates :title, presence: true
  validates :website, presence: true
end
