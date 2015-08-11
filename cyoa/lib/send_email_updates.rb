module SendEmailUpdates
  def self.send_emails
    bill_updates = find_recent_important_bills
    User.find_each do |user|
      selected_bills = user.bills.each_with_object({}) do |bill, result|
        result[bill.id] = bill_updates[bill.id] if bill_updates[bill.id]
      end
      BillUpdateMailer.update(user, selected_bills).deliver_now unless selected_bills.empty?
    end
  end

  def self.find_recent_important_bills
    BillAction.recent.important.each_with_object({}) do |action, bill_updates|
      bill_updates[action.bill.id] ||= []
      bill_updates[action.bill.id] <<= action.text
    end
  end
end
