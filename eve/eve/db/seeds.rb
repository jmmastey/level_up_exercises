# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "yaml"

# Items
items = YAML.load_file("db/item_map.yaml")
items.each do |item_id, details|
  Item.create(id: item_id,
              description: details["description"].strip,
              icon: details["iconFile"].strip)
end
