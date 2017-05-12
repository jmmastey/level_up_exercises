# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do

    sequence(:name) { |i| "Event#{i}" }
    description "Some event"
    price "$20"
    show_type "Play"
    # phone_number 7736794909
    running_time "30 hours"
    event_url "http://some.event.com"
    ticket_url "http://some.event.com/ticket"
    association :venue, factory: :venue

    factory :invalid_event do
      description nil
      price nil
      show_type nil
      running_time nil
      event_url nil
      ticket_url nil
      venue nil

    end

  end
end
