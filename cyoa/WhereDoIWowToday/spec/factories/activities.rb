FactoryGirl.define do
  factory :activity do
    character

    transient do
      category_name "Duskwood"
      activity_faction_id "2"
    end
    category do
      Category.find_by(name: category_name) || FactoryGirl.create(
        :category, name: category_name)
    end

    trait :quest do
      quest do
        FactoryGirl.create(:quest, blizzard_faction_id_num: activity_faction_id)
      end
    end
  end
end
