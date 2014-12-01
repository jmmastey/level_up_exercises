# Base Bill class
class Bill < ActiveRecord::Base
  def title
    short_title || bill_id
  end

  def self.build_object_hash(result)
    {
      bill_id: result['bill_id'],
      bill_type: result['bill_type'],
      number: result['number'],
      congress: result['congress'],
      chamber: result['chamber'],
      introduced_on: result['introduced_on'],
      last_action_at: result['last_action_at'],
      last_vote_at: result['last_vote_at'],
      last_version_on: result['last_version_on'],
      official_title: result['official_title'],
      short_title: result['short_title'],
      sponsor_id: result['sponsor_id'],
      enacted_at: result['history']['enacted_at'],
    }
  end

  def self.all_sorted(page, sort_by = "created_at DESC")
    Bill.order(sort_by).paginate(page: page, per_page: ApplicationHelper::PAGINATION_COUNT)
  end
end
