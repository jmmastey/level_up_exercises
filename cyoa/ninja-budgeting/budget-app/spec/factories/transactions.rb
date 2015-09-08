FactoryGirl.define do
  factory :bank_transaction, class: Transaction do
    description 'Test Bank Transaction'
    date Date.new(2015, 1, 1)
    transaction_type 'expense'
    term_id 1
    paid false
  end

  factory :credit_transaction, class: Transaction do
    description 'Test Credit Transaction'
    date Date.new(2015, 1, 1)
    transaction_type 'expense'
    term_id 1
    paid false
  end

  factory :input_transaction, class: Transaction do
    description 'Test Input Transaction'
    date Date.new(2015, 1, 1)
    transaction_type 'input'
    term_id 1
    paid false
  end
end
