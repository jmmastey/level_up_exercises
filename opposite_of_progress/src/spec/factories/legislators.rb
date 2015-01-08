FactoryGirl.define do
  factory :legislator do
    sequence(:bioguide_id) { |n| "A#{n.to_s.rjust(6, '0')}"}
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    party { %w(D R).sample }
    state { Faker::Address.state_abbr }
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
