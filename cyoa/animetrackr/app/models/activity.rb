class Activity < ActiveRecord::Base
  belongs_to :anime
  belongs_to :user

  def added?
    state.eql?('Added')
  end

  def updated?
    state.eql?('Updated')
  end
end
