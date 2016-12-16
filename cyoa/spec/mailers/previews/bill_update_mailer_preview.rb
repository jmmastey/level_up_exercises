class BillUpdateMailerPreview < ActionMailer::Preview
  def update
    bills = { 655 => ['Resolution agreed to in Senate with amendments',
                      'Senate agreed to conference report'
                     ]
            }
    BillUpdateMailer.update(User.first, bills)
  end
end
