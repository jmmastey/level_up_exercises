class Bill < ActiveRecord::Base
  def to_md5_hash(obj)
    md5 = Digest::MD5.new
    md5.update obj["bill_id"].to_s
    md5 << obj["bill_type"].to_s
    md5 << obj["number"].to_s
    md5 << obj["congress"].to_s
    md5 << obj["chamber"].to_s
    md5 << obj["introduced_on"].to_s
    md5 << obj["last_action_at"].to_s
    md5 << obj["last_vote_at"].to_s
    md5 << obj["last_version_on"].to_s
    md5 << obj["official_title"].to_s
    md5 << obj["short_title"].to_s
    md5 << obj["sponsor_id"].to_s
    md5.hexdigest
  end

  def fetch(path = "#{ApplicationHelper::API_BASE_PATH}bills?apikey=#{ApplicationHelper::API_KEY}&per_page=#{ApplicationHelper::API_PAGE_COUNT}&page=10")
    http = Curl.get(path)
    @results = JSON.parse(http.body_str)

    @results["results"].each do |result|
      bill = Bill.where(bill_id: result['bill_id'])

      if bill.count == 0
        Bill.create(bill_id: result['bill_id'],
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
                    sponsor_id: result['sponsor_id'])
      else
        bill = bill.first

        old_hash = to_md5_hash bill
        new_hash = to_md5_hash result

        unless old_hash == new_hash
          Bill.update(bill.id, bill_type: result['bill_type'],
                      number: result['number'],
                      congress: result['congress'],
                      chamber: result['chamber'],
                      introduced_on: result['introduced_on'],
                      last_action_at: result['last_action_at'],
                      last_vote_at: result['last_vote_at'],
                      last_version_on: result['last_version_on'],
                      official_title: result['official_title'],
                      short_title: result['short_title'],
                      sponsor_id: result['sponsor_id'])
        end
      end
    end
  end
end
