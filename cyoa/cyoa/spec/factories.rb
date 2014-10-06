FactoryGirl.define do
  factory :artist, aliases: [:beyonce] do
    name "Beyonce"
  end

 # factory :service do
 #   name "Facebook"
 #   url "http://facebook.com"
 # end

  factory :song do
    name "Single Ladies"
    artist
  end

  #factory :char
end
