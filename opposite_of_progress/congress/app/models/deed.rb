class Deed < ActiveRecord::Base
  def law_voted_on
    # Get recently voted on bills
    Bill.order(:updated_at).all.each do |bill|
      if bill.last_vote_at && bill.short_title
        # prep deed text
        deed_text = "#{bill.short_title} was last voted on #{bill.last_vote_at}"

        # find an existing deed with the same bill_id and bioguide_id
        result = Deed.where(bill_id: bill.bill_id,
                            bioguide_id: bill.sponsor_id,
                            deed: deed_text)
        if result.count == 0
          deed = Deed.new(bill_id: bill.bill_id,
                          bioguide_id: bill.sponsor_id,
                          deed: deed_text)
          deed.save

          puts "Deed created"
        end
      end
    end
  end

  
end
