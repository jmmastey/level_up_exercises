FactoryGirl.define do
  factory :artist, aliases: [:beyonce] do
    name "Beyonce"
    nbs_id 1111
    grooveshark_id 2222
  end
  
  factory :another_artist, class: Artist, aliases: [:jayz] do
    name "Jay-Z"
    nbs_id 1234
    grooveshark_id 4321
  end

  factory :song do |f|
    f.name "Single Ladies"
    f.association :artist
  end

  factory :category do
    name "fans"
  end

  factory :metric do
    value 10
    category
    artist
  end

  factory :service do
    name "Facebook"
    url "http://facebook.com"
  end
end
