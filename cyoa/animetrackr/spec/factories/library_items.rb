FactoryGirl.define do
  factory :library_item do
    view_status { ["Wishlist", "Currently Watching", "Done"].sample }
    user_rating { rand(5) }
    public { [true, false].sample }
  end
end
