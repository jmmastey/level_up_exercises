FactoryGirl.define do
  factory :selection_criterion do
    implementation_class "Selector::Comparator"
    configuration ({
                    'field' => 'start_time',
                    'sql_operation' => '>',
                    'criterion' => 2.days.ago,
                  })
  end
end
