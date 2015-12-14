require 'congress'

class BillsAPI
  def self.repull_bills
    client = Congress::Client.new("1e1ef54e51a840d7a20dee5768e2459e")
    fields = "summary_short,bill_id,official_title,popular_title,short_title," \
      "bill_type,chamber,congress,introduced_on,last_action_at,last_vote_at," \
      "last_version_on,history,urls"
    (1...5).each do |page|
      bills = client.bills(fields: fields, 
                           per_page: 50, page: page)['results']
      bills.map { |bill| save(bill) }
    end
  end

  def self.save(bill)
    transformed = transform(bill)
    Bill.where(bill_id: transformed[:bill_id]).update_or_create(transformed)
  end

  def self.transform(bill)
    result = {}
    [:official_title, :popular_title, :short_title, :bill_id,
     :bill_type, :chamber, :congress, :introduced_on, :last_action_at,
     :last_vote_at, :last_version_on].each do |simple_property|
      result[simple_property] = bill[simple_property]
    end
    result[:enacted] = bill['history']['enacted']
    result[:congress_url] = bill['urls']['congress']
    result[:summary] = bill['summary_short']
    result
  end
end
