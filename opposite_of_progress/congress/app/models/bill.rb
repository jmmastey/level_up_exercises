class Bill < ActiveRecord::Base
  def title
    return self.short_title if self.short_title
    return self.bill_id
  end

  def fetch path
    http = Curl.get(path)
    @results = JSON.parse(http.body_str)

    @results["results"].each do |result|
      bill = Bill.where(bill_id: result['bill_id'])

      if bill.count == 0
        Bill.create(build_object_hash(result))
      else
        bill = bill.first

        old_hash = ApplicationHelper::to_md5_hash bill
        new_hash = ApplicationHelper::to_md5_hash result, Bill.new

        unless old_hash == new_hash
          Bill.update(bill.id, build_object_hash(result))
        end
      end
    end
  end

  def build_object_hash result
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
      enacted_at: result['history']['enacted_at']
    }
  end
end
