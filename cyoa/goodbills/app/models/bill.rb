class Bill < ActiveRecord::Base

  def update_score(vote)
    # todo: voted already checking / change vote checking
    self.score += 1 if vote == "like"
    self.score -= 1 if vote == "dislike"
    self.num_voted += 1
    self.save!
  end

  def self.get_latest_timestamp
    self.order('last_action_at DESC').first.last_action_at || Date.civil(2000,1,1)
  end

def self.update_or_create(attributes)
  assign_or_new(attributes).save
end

def self.assign_or_new(attributes)
  obj = first || new
  obj.assign_attributes(attributes)
  obj
end
end
