json.results do
  json.array! @legislators, partial: 'legislators/legislator', as: :legislator
end

json.partial! 'legislators/pagination', legislators: @legislators

