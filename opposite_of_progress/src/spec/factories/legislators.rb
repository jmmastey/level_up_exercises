FactoryGirl.define do
  factory :legislator do
    sequence(:bioguide_id) { |n| "A#{n.to_s.rjust(6, '0')}"}
    first_name 'John'
    last_name 'Smith'
    party 'D'
    state 'IL'
    chamber 'house'
    title 'Rep'
    district '3'

    trait :senator_trait do
      chamber 'senate'
      district nil
      state_rank 'junior'
      title 'Sen'
    end

    factory :representative
    factory :senator, traits: [:senator_trait]
  end

end
