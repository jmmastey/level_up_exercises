json.results do
  json.array! @good_deeds, partial: 'good_deeds/good_deed', as: :good_deed
end

json.partial! 'good_deeds/pagination', good_deeds: @good_deeds
