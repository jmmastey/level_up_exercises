require 'congress'

# <Hashie::Mash bill_id="hr4236-114" bill_type="hr" chamber="house" 
# committee_ids=["HSWM"] congress=114 cosponsors_count=16 
# enacted_as=nil history=<Hashie::Mash active=false awaiting_signature=false 
# enacted=false vetoed=false> introduced_on="2015-12-10" last_action_at="2015-12-10" 
# last_version_on="2015-12-10" last_vote_at=nil number=4236
#  official_title="To promote savings by providing a tax credit for eligible 
#  taxpayers who contribute to savings products and to facilitate taxpayers 
#  receiving this credit and open a designated savings product when they file 
#  their Federal income tax returns." popular_title=nil related_bill_ids=[]
#   short_title=nil sponsor=<Hashie::Mash first_name="José" last_name="Serrano" 
#   middle_name="E." name_suffix=nil nickname=nil title="Rep"> sponsor_id="S000248" 
#   urls=<Hashie::Mash congress="http://beta.congress.gov/bill/114th/house-bill/4236"
#    govtrack="https://www.govtrack.us/congress/bills/114/hr4236"
#     opencongress="https://www.opencongress.org/bill/hr4236-114"> 
#     withdrawn_cosponsors_count=0>

class BillsAPI
  def self.repull_bills
    puts "repulling bills"
    client = Congress::Client.new("1e1ef54e51a840d7a20dee5768e2459e")
    fields = "summary_short,bill_id,official_title,popular_title,short_title," \
      "bill_type,chamber,congress,introduced_on,last_action_at,last_vote_at," \
      "last_version_on,history,urls"
    (1...5).each do |page|
      bills = client.bills({fields: fields, per_page: 50, page: page})['results']
      bills.map {|bill| save(bill)} 
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