hash = {"id" => "4d8b92b34eb68a1b2c0003f4"}

FactoryGirl.define do
  factory :retrieve_artist, class: RetrieveArtist do
    artist_params hash
  end
end
