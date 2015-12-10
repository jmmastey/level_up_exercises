class Bill < ActiveRecord::Base

  def update_score(vote)
    # todo: voted already checking / change vote checking
    self.score += 1 if vote == "like"
    self.score -= 1 if vote == "dislike"
    self.num_voted += 1
    self.save!
  end
end
