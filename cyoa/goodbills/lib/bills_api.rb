require 'congress'

class BillsAPI
  def self.repull_bills
    client = Congress::Client.new("1e1ef54e51a840d7a20dee5768e2459e")
    (1...5).each { |page| repull_bill_page(client, page) }
  end

  def self.repull_bill_page(client, page)
    bills = client.bills(fields: FIELDS,
                         per_page: 50,
                         page: page)['results']
    bills.map { |bill| save(bill) }
  end

  def self.save(bill)
    transformed = transform(bill)
    Bill.where(bill_id: transformed[:bill_id]).update_or_create(transformed)
  end

  def self.transform(bill)
    result = add_simple_properties(bill)
    result[:enacted] = bill['history']['enacted']
    result[:congress_url] = bill['urls']['congress']
    result[:summary] = bill['summary_short']
    result
  end

  def self.add_simple_properties(bill)
    [:official_title, :popular_title, :short_title, :bill_id, :last_vote_at,
     :bill_type, :chamber, :congress, :introduced_on, :last_action_at,
     :last_version_on].each_with_object({}) do |simple_property, result|
      result[simple_property] = bill[simple_property]
    end
  end

  FIELDS = "summary_short,bill_id,official_title,popular_title," \
    "bill_type,chamber,congress,introduced_on,last_action_at,last_vote_at," \
    "last_version_on,history,urls,short_title"
end
