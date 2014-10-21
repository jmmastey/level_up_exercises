# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :performer do
    name "John D"
    description "Blargablarg"

    trait(:with_shows) do
      after(:create) do |performer|
        create_list(:show, 2, performers: [performer])
      end
    end
  end
end
