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

  factory :song do
    name "Single Ladies"
    artist
  end

  factory :category do
    name "fans"
  end

  factory :service  do
    name "Facebook"
    url "http://facebook.com"
  end

  factory :another_service, class: Service do
    name "Twitter"
    url "http://twitter.com"
  end

  factory :metric do
    value 10
    nbs_date "16350"
    category
    service
    artist
  end

  factory :user do
    email "csain@enova.com"
    password "password"
  end
end
