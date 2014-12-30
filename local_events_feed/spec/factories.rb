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
