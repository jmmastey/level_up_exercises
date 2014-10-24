# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :performer do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }

    trait(:with_shows) do
      after(:create) do |performer|
        create_list(:show, 2, performers: [performer])
      end
    end

    trait(:with_performances) do
      after(:create) do |performer|
        show = create(:show, performers: [performer])
        performances = create_list(:performance, 10, show: show)
      end
    end
  end
end
