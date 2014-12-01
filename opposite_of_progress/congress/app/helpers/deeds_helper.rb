# Deeds helper module
module DeedsHelper
  def self.law_voted_on
    Bill.order(:updated_at).all.each do |bill|
      if bill.last_vote_at && bill.short_title
        deed_text = "#{bill.short_title} was last voted on " \
          "#{bill.last_vote_at.strftime('%B %d %Y')}"

        result = Deed.where(bill_id: bill.bill_id,
                            bioguide_id: bill.sponsor_id,
                            deed: deed_text)
        if result.count == 0
          deed = Deed.new(bill_id: bill.bill_id,
                          bioguide_id: bill.sponsor_id,
                          deed: deed_text,
                          date: bill.last_vote_at)
          deed.save

          puts "Deed (law voted on) created"
        end
      end
    end
  end

  def self.enacted_into_law
    Bill.order(:updated_at).all.each do |bill|
      if bill.congress == 113 && bill.enacted_at && bill.short_title
        deed_text = "#{bill.short_title} was enacted on " \
          "#{bill.enacted_at.strftime('%B %d %Y')}"

        result = Deed.where(bill_id: bill.bill_id,
                            bioguide_id: bill.sponsor_id,
                            deed: deed_text)
        if result.count == 0
          deed = Deed.new(bill_id: bill.bill_id,
                          bioguide_id: bill.sponsor_id,
                          deed: deed_text,
                          date: bill.enacted_at)
          deed.save

          puts "Deed (enacted into law) created"
        end
      end
    end
  end
end
