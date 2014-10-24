class Bill < ActiveRecord::Base
  def fetch
    http = Curl.get("https://congress.api.sunlightfoundation.com/bills?apikey=2d3136f6874046c8ba34d5e2f1a96b03")
    @results = JSON.parse(http.body_str)

    @results["results"].each do |result|
      bill = Bill.where(bill_id: result['bill_id'])

      if bill.count == 0
        puts 'new bill'

        Bill.create(bill_id: result['bill_id'],
                    bill_type: result['bill_type'],
                    number: result['number'],
                    congress: '113',
                    chamber: 'house',
                    introduced_on: '2014-09-09',
                    last_action_at: '2014-09-19',
                    last_vote_at: '2014-09-18',
                    last_version_on: '2014-09-17',
                    official_title: 'aking continuing appropriations for fiscal year 2015, and for other purposes.',
                    short_title: 'Continuing Appropriations Resolution, 2015')
      else
        puts 'already exists'
      end
    end
  end
end
