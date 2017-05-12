# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_date do
    association :event, factory: :event
    association :venue, factory: :venue
    date_time {DateTime.tomorrow }

    factory :invalid_event_date do
      event nil
      venue nil
      date_time nil

    end

  end
end
