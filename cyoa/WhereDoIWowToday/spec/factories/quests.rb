FactoryGirl.define do
  factory :quest do
    sequence :id
    blizzard_id_num { id + 10 }
    title "Fake Quest Title"
    blizzard_faction_id_num "1"

    transient do
      category_name "Duskwood"
    end

    categories do
      category =
        Category.find_by(name: category_name) || FactoryGirl.create(
          :category, name: category_name)
      [category]
    end
  end
end
