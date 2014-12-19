require "selector"
require "ostruct"

FactoryGirl.define do
  factory :selector_comparator, class: Selector::Comparator do
    skip_create

    initialize_with do
       new.using_configuration_source(OpenStruct.new(configuration: {}))
    end

    field 'a_field_name'
    sql_operator '>'
    criterion 5
  end
end
