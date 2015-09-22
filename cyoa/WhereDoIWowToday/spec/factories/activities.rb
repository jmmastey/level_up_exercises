FactoryGirl.define do
  factory :activity do
    character
    hidden false

    transient do
      category_name "Duskwood"
    end

    category do
      Category.find_by(name: category_name) || FactoryGirl.create(
        :category, name: category_name)
    end

    quest do
      FactoryGirl.create(:quest)
    end
  end
end
