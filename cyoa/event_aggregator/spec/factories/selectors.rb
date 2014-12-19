require "selector"

FactoryGirl.define do
  factory :selector_comparator, class: Selector::Comparator do
    skip_create

    initialize_with { new.with_configuration({}) }

    field 'a_field_name'
    sql_operator '>'
    criterion 5
  end
end
