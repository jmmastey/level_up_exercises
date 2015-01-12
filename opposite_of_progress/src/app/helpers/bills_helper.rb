module BillsHelper
  def link_to_bill(bill, options = {})
    bill_name = bill.official_title
    bill_name = "#{bill.official_id}: #{bill_name}" if options[:without_id].blank?
    link_to(bill_name, bill, options)
  end
end
