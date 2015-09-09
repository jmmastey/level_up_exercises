FactoryGirl.define do
  factory :achievement do
    sequence :blizzard_id_num
    # title "MyString"
    # faction_id 1

    factory :achievement_in_duskwood do
      category do
        Category.find_by(name: "Duskwood") || FactoryGirl.create(
          :category, name: "Duskwood")
      end
    end
  end
end
