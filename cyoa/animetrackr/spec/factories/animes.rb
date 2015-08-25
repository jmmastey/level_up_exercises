FactoryGirl.define do
  sequence :title do |n|
    "anime #{n}"
  end

  factory :anime do
    status { ["Wishlist", "Currently Watching", "Done"].sample }
    title
    episode_count { rand(100) }
    episode_length { rand(120) }
    cover_image "/image.jpg"
    synopsis "A description"
    show_type { %w(TV Movie OVA ONA Special Music).sample }
    community_rating { rand(5) }
  end
end
