FactoryGirl.define do
  factory :artist do
    first_name "Claude"
    last_name  "Monet"
    biography  "Artist biography"
    analysis   "Artist analysis"

    factory :artist_with_artworks do
      transient do
        artworks_count 5
      end

      after(:create) do |artist, evaluator|
        create_list(:artwork, evaluator.artworks_count, artist: artist)
      end
    end
  end
end
