FactoryGirl.define do
  factory :event do
    name 'Party'
    location 'Everywhere'
    link 'www.link.com'
    description 'Please show up'
    showings []

    transient do
      times []
    end

    after(:create) do |event, evaluator|
      evaluator.times.each { |time| event.showings.create(time: time) }
    end
  end
end

# Wasn't sure where to put this
require 'theatre_in_chicago/event'

FactoryGirl.define do
  factory :chicago_event, class: TheatreInChicago::Event do
    skip_create

    name 'Party'
    location 'Everywhere'
    link 'www.link.com'
    image 'www.link.com/picture.jpg'
    description 'Please show up'
    showings [DateTime.parse("20141001T073000")]

    trait :dirty do
      location ' Everywhere     '
    end
  end
end
