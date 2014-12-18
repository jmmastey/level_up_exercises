FactoryGirl.define do
  factory :event_source do
    name "Land of Make Believe"
    source_type "ThinAir"
    uri "brain://localbra2yyin/lefthemi/frontal"
    frequency 1
    last_harvest "2014-12-17 10:29:38"
  end

  trait :with_events do
    transient { events_count 5 }
    transient { step 1.day }
    transient { duration 1.hour }
    transient { initial_time Time.now }

    after(:create) do |source, evaluator|

      evaluator.events_count.times do |n|
        event_time = evaluator.initial_time + (n * evaluator.step)
        FactoryGirl.create(:calendar_event, {
          start_time: event_time,
          end_time: event_time + evaluator.duration,
          event_source: source,
        })
      end
    end
  end
end
