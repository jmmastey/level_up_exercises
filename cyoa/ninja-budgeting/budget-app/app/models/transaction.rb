class Transaction < ActiveRecord::Base
  belongs_to :term
  validates_presence_of :date, :amount, :term_id, :transaction_type
end
