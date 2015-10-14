FactoryGirl.define do
  factory :category do
    sequence(:id, aliases: [:name]) do |n|
      "#{n}"
    end
    blizzard_type "zone"
  end
end
