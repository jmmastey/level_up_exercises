module BillsHelper
  def link_to_bill(bill, options = {})
    bill_name = "#{bill.official_id}: #{bill.official_title}"
    link_to(bill_name, bill, options)
  end
end
