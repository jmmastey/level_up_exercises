FactoryGirl.define do
  factory :feed, class: Feed do
    title "A feed"
    description <<-EOF
      Everything U care about and nothing U don't! (is all in a different feed)
    EOF

    trait :public do
      public true
    end

    trait :with_owner do
      user
    end

    trait :with_selectors do
      after(:create) do |feed, evaluator|
        create(:selection_criterion, feed: feed)
        create(:selection_criterion, 
               field: 'end_time', criterion: 2.days.from_now, feed: feed)
        create(:selection_criterion, field: 'title', sql_operator: "like",    
               criterion: "Blah", feed: feed)
      end
    end

    trait :with_events do
      after(:create) do |feed, evaluator|
        dates = (Time.now.to_i..10.days.from_now.to_i).step(1.day).each do |sec|
          t = Time.at(sec)
          event = create(:calendar_event, start_time: t, end_time: t + 1.hour)
          feed.calendar_events << event
        end
      end
    end
  end
end
