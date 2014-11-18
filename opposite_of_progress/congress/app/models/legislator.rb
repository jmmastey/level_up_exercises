class Legislator < ActiveRecord::Base
  def full_name
    name_arr = []

    name_arr << self.title if self.title
    name_arr << self.first_name if self.first_name
    name_arr << "'#{self.nickname}'" if self.nickname
    name_arr << self.last_name if self.last_name
    name_arr << "(#{self.party})" if self.party

    name_arr.join(" ")
  end

  def full_party
    case self.party
    when "R"
      "Republican"
    when "D"
      "Democrat"
    when "I"
      "Independent"
    when "G"
      "Green"
    end
  end

  def self.build_object_hash result
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
      contact_form: result['contact_form']
    }
  end
end
