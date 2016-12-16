class UserBill < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill

  validates :bill_id, uniqueness: { scope: :user_id,
                                    message: 'Duplicate bookmark'
                                  }
end
