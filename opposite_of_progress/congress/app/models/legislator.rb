# Base Legislator class
class Legislator < ActiveRecord::Base
  scope :by_bioguide_id, ->(id) { where(bioguide_id: id).first }
  scope :all_sorted, ->(page, sort_by) { order(sort_by).paginate(page: page) }

  def full_name
    [title, first_name, nickname, last_name, display_party].compact.join(" ")
  end

  def display_party
    "(#{party})" if party
  end

  def full_party
    case party
      when "R" then "Republican"
      when "D" then "Democrat"
      when "I" then "Independent"
      when "G" then "Green"
      else "Politician"
    end
  end

  def self.from_api_result(result)
    {
      bioguide_id: result['bioguide_id'],
      birthday: result['birthday'],
      chamber: result['chamber'],
      party: result['party'],
      title: result['title'],
      term_start: result['term_start'],
      term_end: result['term_end'],
      gender: result['gender'],
      first_name: result['first_name'],
      nickname: result['nickname'],
      middle_name: result['middle_name'],
      last_name: result['last_name'],
      state: result['state'],
      twitter_id: result['twitter_id'],
      facebook_id: result['facebook_id'],
      phone: result['phone'],
      website: result['website'],
      office: result['office'],
      contact_form: result['contact_form'],
    }
  end
end
