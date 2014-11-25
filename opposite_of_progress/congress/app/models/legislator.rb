class Legislator < ActiveRecord::Base
  def full_name
    name_arr = []

    name_arr << title if title
    name_arr << first_name if first_name
    name_arr << "'#{nickname}'" if nickname
    name_arr << last_name if last_name
    name_arr << "(#{party})" if party

    name_arr.join(" ")
  end

  def full_party
    case party
      when "R"
        "Republican"
      when "D"
        "Democrat"
      when "I"
        "Independent"
      when "G"
        "Green"
      else
        "Politician"
      end
  end

  def self.build_object_hash(result)
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
