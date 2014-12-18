FactoryGirl.define do
  factory :selection_criterium do
    implementation_class "MyString"
configuration "MyText"
sql_expression "MyString"
  end

end
