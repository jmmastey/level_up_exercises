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

  def fetch(path = "#{ApplicationHelper::API_BASE_PATH}legislators?apikey=2d3136f6874046c8ba34d5e2f1a96b03&per_page=50&page=1")
    http = Curl.get(path)
    @results = JSON.parse(http.body_str)

    @results["results"].each do |result|
      legislator = Legislator.where(bioguide_id: result['bioguide_id'])

      if legislator.count == 0
        Legislator.create(bioguide_id: result['bioguide_id'],
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
                          contact_form: result['contact_form'])
      else
        legislator = legislator.first

        old_hash = ApplicationHelper::to_md5_hash legislator
        new_hash = ApplicationHelper::to_md5_hash result, Legislator.new

        unless old_hash == new_hash
          Legislator.update(legislator.id, 
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
                            contact_form: result['contact_form'])
        end
      end
    end
  end
end
