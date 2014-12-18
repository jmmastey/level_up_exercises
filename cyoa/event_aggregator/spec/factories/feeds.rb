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
      owner :user
    end

    trait :with_selectors do
      #create_list(..... selectors, self)
    end

    trait :with_events do
      # :with_selectors
      # :create_events
      # :refresh feed
    end
  end
end
