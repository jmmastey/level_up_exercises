class Legislator < ActiveRecord::Base
  def fetch
    http = Curl.get("https://congress.api.sunlightfoundation.com/legislators?apikey=2d3136f6874046c8ba34d5e2f1a96b03")
    @results = JSON.parse(http.body_str)

    @results["results"].each do |result|
      legislator = Legislator.where(bioguide_id: result['bioguide_id'])

      if legislator.count == 0
        # create the legislator
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
                          facebook_id: result['facebook_id'])
      else
        legislator = legislator.first
        # check for update
        md5 = Digest::MD5.new
        md5.update legislator.bioguide_id.to_s
        md5 << legislator.birthday.to_s
        md5 << legislator.chamber.to_s
        md5 << legislator.party.to_s
        md5 << legislator.title.to_s
        md5 << legislator.term_start.to_s
        md5 << legislator.term_end.to_s
        md5 << legislator.gender.to_s
        md5 << legislator.first_name.to_s
        md5 << legislator.nickname.to_s
        md5 << legislator.middle_name.to_s
        md5 << legislator.last_name.to_s
        md5 << legislator.state.to_s
        md5 << legislator.twitter_id.to_s
        md5 << legislator.facebook_id.to_s
        old_hash = md5.hexdigest

        md5 = Digest::MD5.new
        md5.update result['bioguide_id'].to_s
        md5 << result['birthday'].to_s
        md5 << result['chamber'].to_s
        md5 << result['party'].to_s
        md5 << result['title'].to_s
        md5 << result['term_start'].to_s
        md5 << result['term_end'].to_s
        md5 << result['gender'].to_s
        md5 << result['first_name'].to_s
        md5 << result['nickname'].to_s
        md5 << result['middle_name'].to_s
        md5 << result['last_name'].to_s
        md5 << result['state'].to_s
        md5 << result['twitter_id'].to_s
        md5 << result['facebook_id'].to_s
        new_hash = md5.hexdigest

        if old_hash == new_hash
          puts 'they match, no update needed'
        else
          puts 'not matching, update this record'
        end
      end
    end
  end
end
