component_hash = { 'Available' => 89.65, 'Reserved' => {}, 'Pending' => {} }

FactoryGirl.define do
  factory :bank_fund, class: Fund do
    name 'Bank Fund'
    amount 89.65
    fund_type 'bank'
    user_id 1
    components component_hash
  end

  factory :credit_fund, class: Fund do
    name 'Credit Fund'
    amount 45.67
    fund_type 'credit'
    user_id 1
    components component_hash
  end
end
